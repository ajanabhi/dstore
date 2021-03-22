import 'package:analyzer/dart/element/element.dart';
import 'package:dstore_generator/src/form/visitors.dart';
import 'package:dstore_generator/src/utils/utils.dart';

String generateFormModel(ClassElement element) {
  final typeParamsWithBounds =
      element.typeParameters.map((e) => e.toString()).join(",");
  final typeParams = element.typeParameters.map((e) => e.name).join(",");
  final modelName = element.name.substring(2);
  final visitor = FormModelVisitor(element.fields, modelName);
  final astNode = AstUtils.getAstNodeFromElement(element);
  astNode.visitChildren(visitor);

  final annotations = element.metadata
      .map((e) => e.toSource())
      .where((e) => !e.startsWith("@FormModel"))
      .toList();

  return """

   ${_createModel(name: modelName, fields: visitor.fields, typeParams: typeParams, typeParamsWithBounds: typeParamsWithBounds, annotations: annotations)}

   ${_createEnum(element.fields, modelName)}

   ${_createValidator(validators: visitor.validators, enumName: visitor.enumName, modelName: modelName)}
     
     """;
}

String _createValidator(
    {required Map<String, String> validators,
    required String modelName,
    required String enumName}) {
  final mapType = "<$enumName,FormFieldValidator>";
  return """
    Map$mapType create${modelName}Validators() {
      return ${mapType}{${validators.entries.map((e) => "${e.key}: ${e.value}").join(", ")}}
    }
  """;
}

String _createModel(
    {required String name,
    required List<Field> fields,
    required String typeParams,
    required String typeParamsWithBounds,
    bool isJson = false,
    required List<String> annotations}) {
  return """
      
      @immutable
      ${annotations.join("\n")}
      class ${name}  implements FormFieldObject<$name> {
  
        ${ModelUtils.getFinalFieldsFromFieldsList(fields)}
        ${ModelUtils.getCopyWithField(name)}
        ${ModelUtils.createConstructorFromFieldsList(name, fields, addConst: false)}

        ${ModelUtils.createCopyWithMapFromFieldsList(name, fields)}

        ${ModelUtils.createToMapFromFieldsList(fields)}
        
        ${ModelUtils.createEqualsFromFieldsList(name, fields)}

        ${ModelUtils.createHashcodeFromFieldsList(fields)}

        ${ModelUtils.createToStringFromFieldsList(name, fields)}

        ${isJson ? ModelUtils.createFromJson(name) : ""}

        ${isJson ? ModelUtils.createToJson(name) : ""}
      }

      ${ModelUtils.createCopyWithClasses(name: name, typeParams: typeParams, typeParamsWithBounds: typeParamsWithBounds, fields: fields)}
   """;
  ;
}

String _createEnum(List<FieldElement> fields, String modelName) {
  final keys = fields.map((e) => e.name).join(", ");
  final name = "${modelName}Keys";
  return """
     enum $name {
       $keys
     }
     extension  ${name}Ext on $name {
        String get value => toString().split(".").last;
          static $name? fromValue(String value) {
            return ${name}.values
               .singleWhereOrNull((e) => e.toString().split(".")[1] == value);
          }
     }
  """;
}
