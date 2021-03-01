import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:ansicolor/ansicolor.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:dstore/dstore.dart';
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
      ansiColorDisabled = false;
      if (!(element is ClassElement) || !element.isAbstract) {
        throw Exception("DImmutable should only be used on immutable classes");
      }
      print("ctors ${element.constructors.length}");
      // if (element.constructors.length != 1 ||
      //     !element.constructors.first.isFactory) {
      //   throw Exception(
      //       "DImmutable class should contain only single factory constructor");
      // }
      final ctor = element.constructors.first;
      if (!ctor.parameters.every((p) => p.isNamed)) {
        throw Exception(
            "DImmutable constructor should contain only named params");
      }
      final astNode = AstUtils.getAstNodeFromElement(element);
      final astVisitor = DImmutableAstVisitor();
      astNode.visitChildren(astVisitor);
      print(astVisitor);
      final fields =
          processFields(AstUtils.convertParamElementsToFields(ctor.parameters));
      final name = element.name;
      print("Params : $fields");
      return """
      ${_createMixin(name, fields)}

      ${_createClass(name, fields)}

      ${ModelUtils.createCopyWithClasses(name, fields)}
    """;
    } catch (e, st) {
      logger.error(
          "Exception in generating immutable class for ${element.name}", e, st);
      rethrow;
    }
  }
}

class DImmutableAstVisitor extends SimpleAstVisitor {
  final List<Field> fields = [];
  String? jsonSerializable;
  // @override
  // dynamic visitFieldDeclaration(FieldDeclaration node) {
  //   final typeA = node.fields.type as TypeAnnotation?;
  //   if (typeA == null) {
  //     throw Exception("Should provide type annotation for fields");
  //   }
  //   final type = typeA.toString();
  //   node.fields.variables.forEach((v) {
  //     final name = v.name.toString();
  //     final valueE = v.initializer as Expression?;
  //     if (!type.endsWith("?") && valueE == null) {
  //       throw Exception("Should provide initital value for fields");
  //     }
  //     // final value = type.endsWith("?") ? "null" : valueE.toString();
  //     fields.add(Field(name: name, type: type, value: valueE.toString()));
  //   });
  //   print(
  //       "declared element : ${node.fields.type} node : ${node.fields.variables[0]}");
  //   return super.visitFieldDeclaration(node);
  // }
  @override
  dynamic visitConstructorDeclaration(ConstructorDeclaration node) {
    if (node.factoryKeyword != null) {
      print("Factory Constructor ${node.name?.name}");
      if (node.name == null) {
        // defaul factory constructor
        fields.addAll(AstUtils.convertParamsToFields(node.parameters,
            isDImmutable: true));
      }
      jsonSerializable = node.metadata
          .singleWhereOrNull((a) => a.toString().startsWith("JosnSerializable"))
          ?.toString();
    }
    return super.visitConstructorDeclaration(node);
  }

  @override
  String toString() {
    return "DImmutableAstVisitor(fields :$fields josnSerializable : $jsonSerializable)";
  }
}

String _createMixin(String name, List<Field> fields) {
  // final params = fields
  //     .map((f) =>
  //         "${(f.type.endsWith("?") || f.isOptional) ? "Nullable<${f.type.replaceFirst("?", "")}>?" : "${f.type}?"} ${f.name}")
  //     .join(", ");
  return """
   mixin _\$$name {

    ${fields.map((f) => "${f.isOptional && !f.type.endsWith("?") ? "${f.type}?" : f.type} get ${f.name};").join("\n")}
    
    @JsonKey(ignore: true)
    \$${name}CopyWith<${name}> get copyWith;
   
   }
  """;
}

String _createClass(String name, List<Field> fields) {
  final className = "_$name";
  return """
   class $className implements $name {
     
     ${ModelUtils.getFinalFieldsFromFieldsList(fields, addOverrideAnnotation: true)}
     
     ${ModelUtils.getCopyWithField(name)}
      
     ${ModelUtils.createConstructorFromFieldsList(className, fields)}
     
     ${ModelUtils.createEqualsFromFieldsList(className, fields)}

     ${ModelUtils.createHashcodeFromFieldsList(fields)}

     ${ModelUtils.createToStringFromFieldsList(name, fields)}
   }
  
  """;
}
