import 'dart:developer';

import 'package:ansicolor/ansicolor.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:dstore_annotation/dstore_annotation.dart';
import 'package:dstore_generator/src/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';
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

      final ctor = element.constructors
          .singleWhereOrNull((c) => c.isFactory && c.name.isEmpty);
      if (ctor == null) {
        throw ArgumentError.value(
            "DImmutable should have factory constructor with non name");
      }
      if (!ctor.parameters.every((p) => p.isNamed)) {
        throw ArgumentError.value(
            "DImmutable constructor should contain only named params");
      }
      final typeParamsWithBounds =
          element.typeParameters.map((e) => e.toString()).join(",");
      final typeParams = element.typeParameters.map((e) => e.name).join(",");
      logger
          .shout("typeParams : $typeParamsWithBounds fields ${element.fields}");

      final fields = processFields(
          AstUtils.convertParamElementsToFields(ctor.parameters, dim: true));
      final name = element.name;
      print("Params : $fields");
      final annotations = <String>[];
      final jsonSerializableAnnot = ctor.annotationFromType(JsonSerializable);
      if (jsonSerializableAnnot != null) {
        annotations.add(jsonSerializableAnnot.toSource());
      }
      final isJosnSerializable = jsonSerializableAnnot != null;
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
