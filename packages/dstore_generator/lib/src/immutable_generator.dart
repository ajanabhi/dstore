import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:ansicolor/ansicolor.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:dstore_annotation/dstore_annotation.dart';
import 'package:dstore_generator/src/utils/utils.dart';
import 'package:gql/ast.dart';
import 'package:logging/logging.dart';
import 'package:source_gen/source_gen.dart';
import 'package:collection/collection.dart';

class DImmutableGenerator extends GeneratorForAnnotation<DImmutable> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    try {
      logger.shout("Genertating DImmutable for ${element.name}");
      ansiColorDisabled = false;
      if (!(element is ClassElement)) {
        throw UnsupportedError("DImmutable should only be used on classes");
      }
      print("ctors ${element.constructors.length}");
      // if (element.constructors.length != 1 ||
      //     !element.constructors.first.isFactory) {
      //   throw Exception(
      //       "DImmutable class should contain only single factory constructor");
      // }
      final ctor = element.constructors.first;
      if (!ctor.parameters.every((p) => p.isNamed)) {
        throw ArgumentError.value(
            "DImmutable constructor should contain only named params");
      }
      final typeParamsWithBounds =
          element.typeParameters.map((e) => e.toString()).join(",");
      final typeParams = element.typeParameters.map((e) => e.name).join(",");
      logger.shout("typeParams : $typeParamsWithBounds");
      final astNode = AstUtils.getAstNodeFromElement(element);
      final astVisitor = DImmutableAstVisitor();
      astNode.visitChildren(astVisitor);
      print(astVisitor);
      final fields = processFields(astVisitor.fields);
      final name = element.name;
      print("Params : $fields");
      final annotations = <String>[];
      final jsonSerializableAnno = astVisitor.jsonSerializable;
      if (jsonSerializableAnno != null) {
        annotations.add(jsonSerializableAnno);
      }
      final isJosnSerializable = jsonSerializableAnno != null;
      final result = """
      ${_createMixin(name: name, fields: fields, typeParams: typeParams, typeParamsWithBounds: typeParamsWithBounds, isJsonSerializable: isJosnSerializable)}

      ${_createClass(name: name, fields: fields, typeParams: typeParams, typeParamsWithBounds: typeParamsWithBounds, annotations: annotations, isJsonSerializable: isJosnSerializable)}
      ${isJosnSerializable ? "$name _\$${name}FromJson(Map<String,dynamic> json) => _${name}.fromJson(json);" : ""}
      ${ModelUtils.createCopyWithClasses(name: name, fields: fields, typeParamsWithBounds: typeParamsWithBounds, typeParams: typeParams)}
    """;
      return result;
    } catch (e, st) {
      logger.error(
          "Error in generating immutable class for ${element.name}", e, st);
      rethrow;
    }
  }
}

class DImmutableAstVisitor extends SimpleAstVisitor {
  final List<Field> fields = [];
  String? jsonSerializable;
  @override
  dynamic visitConstructorDeclaration(ConstructorDeclaration node) {
    if (node.factoryKeyword != null) {
      print("Factory Constructor ${node.name?.name}");
      if (node.name == null) {
        // defaul factory constructor
        fields.addAll(AstUtils.convertParamsToFields(node.parameters,
            isDImmutable: true));
        jsonSerializable = node.metadata
            .singleWhereOrNull(
                (a) => a.toString().startsWith("@JsonSerializable"))
            ?.toString();
      }
    }
    return super.visitConstructorDeclaration(node);
  }

  @override
  String toString() {
    return "DImmutableAstVisitor(fields :$fields josnSerializable : $jsonSerializable)";
  }
}

String _createMixin(
    {required String name,
    required List<Field> fields,
    required String typeParamsWithBounds,
    required String typeParams,
    required bool isJsonSerializable}) {
  // final params = fields
  //     .map((f) =>
  //         "${(f.type.endsWith("?") || f.isOptional) ? "Nullable<${f.type.replaceFirst("?", "")}>?" : "${f.type}?"} ${f.name}")
  //     .join(", ");
  return """
   mixin _\$$name${typeParamsWithBounds.isEmpty ? "" : "<$typeParamsWithBounds>"} {

    ${fields.map((f) => "${f.isOptional && !f.type.endsWith("?") ? "${f.type}?" : f.type} get ${f.name};").join("\n")}
    
    ${isJsonSerializable ? "@JsonKey(ignore: true)" : ""}
    \$${name}CopyWith<${typeParams.isEmpty ? "" : "${typeParams},"}${name}${typeParams.isEmpty ? "" : "<${typeParams}>"}> get copyWith;
    ${isJsonSerializable ? ModelUtils.createToJson() : ""}
   }
  """;
}

String _createClass(
    {required String name,
    required List<Field> fields,
    required String typeParams,
    required String typeParamsWithBounds,
    required List<String> annotations,
    required bool isJsonSerializable}) {
  final className = "_$name";
  return """
  ${annotations.join("\n")}
   class $className${typeParamsWithBounds.isEmpty ? "" : "<$typeParamsWithBounds>"} implements $name${typeParams.isEmpty ? "" : "<$typeParams>"} {
     
     ${ModelUtils.getFinalFieldsFromFieldsList(fields, addOverrideAnnotation: true)}
     
     ${ModelUtils.getCopyWithField(name, addJsonKey: isJsonSerializable, typeParams: typeParams)}
      
     ${ModelUtils.createConstructorFromFieldsList(className, fields)}
     
      ${isJsonSerializable ? ModelUtils.createFromJson(className) : ""}

      ${isJsonSerializable ? ModelUtils.createToJson(className) : ""}

     ${ModelUtils.createEqualsFromFieldsList(className, fields)}

     ${ModelUtils.createHashcodeFromFieldsList(fields)}

     ${ModelUtils.createToStringFromFieldsList(name, fields)}
   }
  
  """;
}
