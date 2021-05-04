import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:dstore_annotation/dstore_annotation.dart';
import 'package:dstore_generator/src/graphql/schema_source/dgraph/dgraph.dart';
import 'package:dstore_generator/src/utils/utils.dart';
import 'package:source_gen/source_gen.dart';

Future<void> generateSchema(
    {required ClassElement element, required BuildStep buildStep}) async {
  final schemaMeta = _getGraphqlSchema(element);
  var schemaStr = "";
  element.fields.forEach((fe) {
    logger.shout(
        "name ${fe.name} type ${fe.type} ${fe.type.runtimeType} type element  : ${fe.type.element}");
    if (fe.name.toLowerCase() == "objects") {
      schemaStr += getObjects(element: element, schema: schemaMeta);
    }
    (fe.type.element as ClassElement).allSupertypes.forEach((st) {
      print(st.getDisplayString(withNullability: true));
      print(st.element.fields);
    });
  });
}

String getObjects(
    {required ClassElement element, required GraphqlSchema schema}) {
  return element.allSupertypes
      .where((e) => !e.isDartCoreObject)
      .map((e) {})
      .join("\n");
}

String convertDartInterfaceTypeToObject(
    {required InterfaceType it, required GraphqlDatabase database}) {
  final element = it.element;
  final name = element.name;

  final interfaces = element.allSupertypes
      .where((e) => !e.isDartCoreObject)
      .map((e) => e.element.name)
      .join(", ");
  final impl = interfaces.isEmpty ? "" : "implements $interfaces";
  var interfacesFields = "";

  return """
   type $name $impl {
    ${getFieldsFromClassElement(element: it.element, database: database)}
    $interfacesFields
   }
  """;
}

String convertDartInterfaceTypeToInterface(
    {required InterfaceType it, required GraphqlDatabase database}) {
  final element = it.element;
  final name = element.name;

  var interfacesFields = "";

  return """
   interface $name  {
    ${getFieldsFromClassElement(element: it.element, database: database)}
    $interfacesFields
   }
  """;
}

String getFieldsFromClassElement(
    {required ClassElement element, required GraphqlDatabase database}) {
  return element.fields.map((e) {
    final type = getGraphqlType(e.type);
    final name = e.name;
    return "$name: $type ";
  }).join("\n");
}

String getAnnotationsForField(
    {required FieldElement fe, required GraphqlDatabase database}) {
  if (database == GraphqlDatabase.dgraph) {
    return getDGraphFieldAnnotations(element: fe);
  }
  return "";
}

String getGraphqlType(DartType type) {
  final req =
      type.getDisplayString(withNullability: true).endsWith("?") ? "" : "!";
  if (type.isDartCoreList) {
    return "[${getGraphqlType((type as InterfaceType).typeArguments.first)}]$req";
  } else if (type.isDartCoreInt) {
    return "Int$req";
  } else if (type.isDartCoreBool) {
    return "Boolean$req";
  } else if (type.isDartCoreDouble) {
    return "Float$req";
  } else if (type.isDartCoreNum) {
    return "Float$req";
  } else {
    return "${type.getDisplayString(withNullability: false)}$req";
  }
}

GraphqlSchema _getGraphqlSchema(ClassElement element) {
  final annot = element.annotationFromType(GraphqlSchema)!;
  final reader = ConstantReader(annot.computeConstantValue());
  final path = reader.peek("path")!.stringValue;
  print("database ${reader.peek("database")}");
  final database = reader.getEnumField("database", GraphqlDatabase.values)!;
  final uploadSchema = reader.peek("uploadSchema")?.boolValue ?? false;
  return GraphqlSchema(
      path: path, database: database, uploadSchema: uploadSchema);
}
