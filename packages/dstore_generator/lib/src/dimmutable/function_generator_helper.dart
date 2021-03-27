import 'package:analyzer/dart/element/element.dart';
import 'package:dstore_generator/src/errors.dart';
import 'package:dstore_generator/src/utils/utils.dart';

String generateDImmutableFromFunction(FunctionElement element) {
  if (!element.name.startsWith("\$_")) {
    throw NotAllowedError(
        "dimmutable function name should start with \$_ , but you specified ${element.name}");
  }
  final className = element.name.substring(2);
  final isJsonSerializable = false;
  final tuple = AstUtils.getTypeParamsAndBounds(element.typeParameters);
  final typeParamsWithBounds = tuple.item2;
  final typeParams = tuple.item1;
  element.parameters.forEach((element) {
    print(element);
    print(element.defaultValueCode);
  });
  final fields = AstUtils.convertParamElementsToFields(element.parameters);
  logger.shout("Fields $fields");

  return """
    
    class $className<$typeParamsWithBounds> {
         
     ${ModelUtils.getFinalFieldsFromFieldsList(fields, addOverrideAnnotation: true)}
     
     ${ModelUtils.getCopyWithField(className, addJsonKey: isJsonSerializable, typeParams: typeParams)}
      
     ${ModelUtils.createConstructorFromFieldsList(className, fields)}
     
      ${isJsonSerializable ? ModelUtils.createFromJson(className) : ""}

      ${isJsonSerializable ? ModelUtils.createToJson(className) : ""}

     ${ModelUtils.createEqualsFromFieldsList(className, fields)}

     ${ModelUtils.createHashcodeFromFieldsList(fields)}

     ${ModelUtils.createToStringFromFieldsList(className, fields)}
    }

    ${ModelUtils.createCopyWithClasses(name: className, fields: fields, typeParamsWithBounds: typeParamsWithBounds, typeParams: typeParams)}
  """;
}
