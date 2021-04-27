import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dstore_annotation/dstore_annotation.dart';
import 'package:dstore_generator/src/utils/utils.dart';
import 'package:source_gen/source_gen.dart';

Future<void> generateSchema(
    {required ClassElement element, required BuildStep buildStep}) async {
  final schemaMeta = _getGraphqlSchema(element);
  var schemaStr = "";
  element.fields.forEach((fe) {
    logger.shout(
        "name ${fe.name} type ${fe.type} type element  : ${fe.type.element}");
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
      .where((e) => e.getDisplayString(withNullability: false) != "Object")
      .map((e) {})
      .join("\n");
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
