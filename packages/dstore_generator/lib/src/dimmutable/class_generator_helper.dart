import 'package:analyzer/dart/element/element.dart';
import 'package:dstore_generator/src/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

String generateDImmutableFromClass(ClassElement element) {
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
  final tuple = AstUtils.getTypeParamsAndBounds(element.typeParameters);
  final typeParamsWithBounds = tuple.item2;
  final typeParams = tuple.item1;
  logger.shout("typeParams : $typeParamsWithBounds fields ${element.fields}");

  final fields = ModelUtils.processFields(
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
