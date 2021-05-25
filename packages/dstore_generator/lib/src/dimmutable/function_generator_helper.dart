import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dstore_generator/src/dimmutable/vistors.dart';
import 'package:dstore_generator/src/errors.dart';
import 'package:dstore_generator/src/utils/utils.dart';

Future<String> generateDImmutableFromFunction(
    {required FunctionElement element, required BuildStep buildStep}) async {
  if (!element.name.startsWith("\$_")) {
    throw NotAllowedError(
        "dimmutable function name should start with \$_ , but you specified ${element.name}");
  }
  final className = element.name.substring(2);
  final isJsonSerializable = false;
  final tuple = AstUtils.getTypeParamsAndBounds(element.typeParameters);
  final typeParamsWithBounds = tuple.item2;
  final tpwb = typeParamsWithBounds.isEmpty ? "" : "<$typeParamsWithBounds>";
  final typeParams = tuple.item1;
  element.parameters.forEach((element) {
    print(element);
    print(element.defaultValueCode);
  });

  final visitor = DImmutableFunctionVisitor();
  final ast = await AstUtils.getAstNodeFromElement(element, buildStep);
  ast.childEntities.forEach((element) {
    print(
        "function element entity ${element} runtime type ${element.runtimeType}");
  });
  ast.visitChildren(visitor);
  print("visitor fields ${visitor.fields}");

  final fields = ModelUtils.processFields(visitor.fields);
  print("dimmutable function fields $fields");
  return """
    
    class $className$tpwb {
         
     ${ModelUtils.getFinalFieldsFromFieldsList(fields)}
     
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
