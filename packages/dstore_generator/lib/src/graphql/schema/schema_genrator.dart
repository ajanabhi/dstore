import 'dart:convert';

import 'package:analyzer/dart/constant/value.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:dio/dio.dart';
import 'package:dstore_annotation/dstore_annotation.dart';
import 'package:dstore_generator/src/graphql/globals.dart';
import 'package:dstore_generator/src/graphql/ops/typegen.dart';
import 'package:dstore_generator/src/graphql/schema/introspection.dart';

import 'package:dstore_generator/src/utils/utils.dart';
import 'package:gql/language.dart' as glang;
import 'package:gql/schema.dart' as gschema;
import 'package:source_gen/source_gen.dart';
import "dart:io";

class GraphqlSchemaGenerator extends GeneratorForAnnotation<GraphqlApi> {
  @override
  Future<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    try {
      if (!(element is ClassElement)) {
        throw Exception(
            "Graphql Api annotation should only be applied on classes");
      }

      final gApi = getGraphqlApi(element.metadata.first.computeConstantValue());
      final schema = await getGraphqlSchemaFromApiUrl(gApi);
      final enums = schema.enums.map((e) => _convertGEnumToDEnum(e)).join("\n");
      final inputs = schema.inputObjectTypes
          .map((e) => _convertGInputTypeToDType(e, gApi.scalarMap))
          .join("\n");
      final dslTypes = getDslTypes(schema);
      return """
      
      $enums 

      $inputs

      $dslTypes
    
    """;
    } catch (e, st) {
      logger.error(
          "Error in generate GraphqlSchema  for ${element.name}", e, st);
      rethrow;
    }
  }
}

String getDslTypes(gschema.GraphQLSchema schema) {
  return """"
  
  
  """;
}

GraphqlApi getGraphqlApi(DartObject? obj) {
  final gApi = obj;
  if (gApi == null) {
    throw ArgumentError.value(
        "Error while computing @GraphqlApi annotation, make sure you used all constant values for api config");
  }
  final apiUrl = gApi.getField("apiUrl")!.toStringValue()!;
  final schemaPath = gApi.getField("schemaPath")?.toStringValue();
  final wsUrl = gApi.getField("wsUrl")?.toStringValue();
  final scalarMap = gApi.getField("scalarMap")?.toMapValue()?.map(
      (key, value) => MapEntry(key!.toStringValue()!, value!.toStringValue()!));
  logger.shout("Scalar Map $scalarMap");
  return GraphqlApi(
      apiUrl: apiUrl,
      scalarMap: scalarMap,
      schemaPath: schemaPath,
      wsUrl: wsUrl);
}

String _convertGEnumToDEnum(gschema.EnumTypeDefinition genum) {
  final name = genum.name;
  final values = genum.values.map((v) => v.name).join(", ");
  final result = "enum $name { $values }";
  return result;
}

String _convertGInputTypeToDType(
    gschema.InputObjectTypeDefinition it, Map<String, String>? scalarMap) {
  final name = it.name;
  final fields = it.fields.map((gf) {
    final name = gf.name;
    final gtype = gf.type;
    var type =
        getScalarTypeFromString(gtype.baseTypeName, scalarMap: scalarMap);
    var isOptional = false;
    if (gtype.isNonNull) {
      if (gtype is gschema.ListType) {
        final lit = gtype.type;
        if (lit.isNonNull) {
          type = "List<$type>";
        } else {
          type = "List<$type?>";
        }
      }
    } else {
      isOptional = true;
      if (gtype is gschema.ListType) {
        final lit = gtype.type;
        if (lit.isNonNull) {
          type = "List<$type>";
        } else {
          type = "List<$type?>";
        }
      }
    }
    return Field(
      name: name,
      type: type,
      isOptional: isOptional,
    );
  }).toList();

  return ModelUtils.createDefaultDartModelFromFeilds(
      fields: ModelUtils.processFields(fields),
      className: name,
      isJsonSerializable: true);
}

Future<gschema.GraphQLSchema> getGraphqlSchemaFromApiUrl(
    GraphqlApi graphqlApi) async {
  late gschema.GraphQLSchema schema;
  final url = graphqlApi.apiUrl;
  final schemaPath = graphqlApi.schemaPath;
  print("Trying to get schema from url $url");
  try {
    final dio = Dio();
    final resp =
        await dio.post<dynamic>(url, data: {"query": getIntrospectionQuery()});
    final respStr = jsonEncode(resp.data);
    await File("./schema.json").writeAsString(respStr);
    schema = buildSchemaFromIntrospection(
        IntrospectionQuery.fromJson(resp.data["data"] as Map<String, dynamic>));
  } catch (e) {
    if (schemaPath != null) {
      print(
          "Error getting schema from apiUrl $e , Try to get schema from file $schemaPath");
      schema = await getSchemaFromPath(schemaPath);
    } else {
      throw Exception(
          "Error while getting graphql schema from api url $url $e ");
    }
  }
  graphqlSchemaMap[url] = schema;
  return schema;
}

Future<gschema.GraphQLSchema> getSchemaFromPath(String schemaPath) async {
  try {
    final schemaStr = await File(schemaPath).readAsString();
    final schemaDoc = glang.parseString(schemaStr);
    return gschema.GraphQLSchema.fromNode(schemaDoc);
  } catch (e) {
    throw Exception("Error getting schema from file $schemaPath");
  }
}
