import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dstore_annotation/dstore_annotation.dart';
import 'package:dstore_generator/src/utils/utils.dart';
import 'package:source_gen/source_gen.dart';

void generateSchema(
    {required ClassElement element, required BuildStep buildStep}) {
  final schemaMeta = _getGraphqlSchema(element);
}

GraphqlSchema _getGraphqlSchema(ClassElement element) {
  final annot = element.annotationFromType(GraphqlSchema)!;
  final reader = ConstantReader(annot.computeConstantValue());
  final path = reader.peek("path")!.stringValue;
  final database = reader.getEnumField("database", GraphqlDatabase.values)!;
  final uploadSchema = reader.peek("uploadSchema")?.boolValue ?? false;
  final schemaUploadFn = reader.objectValue
      .getField("schemaUplodFn")
      ?.toFunctionValue() as SchemaUploadFn?;
  return GraphqlSchema(
      path: path,
      database: database,
      uploadSchema: uploadSchema,
      schemaUplodFn: schemaUploadFn);
}
