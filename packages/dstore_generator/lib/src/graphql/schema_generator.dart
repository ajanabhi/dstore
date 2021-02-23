import 'dart:convert';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:dio/dio.dart';
import 'package:dstore/dstore.dart';
import 'package:dstore_generator/src/graphql/globals.dart';
import 'package:dstore_generator/src/graphql/introspection.dart';
import 'package:dstore_generator/src/utils/utils.dart';
import 'package:gql/language.dart' as glang;
import 'package:gql/schema.dart' as gschema;
import 'package:source_gen/source_gen.dart';
import "dart:io";

class GraphlSchemaGenerator extends GeneratorForAnnotation<GraphqlApi> {
  @override
  Future<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    if (!(element is ClassElement)) {
      throw Exception(
          "Graphql Api annotation should only be applied on classes");
    }

    final gApi = element.metadata.first.computeConstantValue();
    print("gApi $gApi , apiUrl ${gApi.getField("apiUrl")}");
    final apiUrl = gApi.getField("apiUrl").toStringValue();
    final schemaPath = gApi.getField("schemaPath")?.toStringValue();
    final wsUrl = gApi.getField("wsUrl")?.toStringValue();

    final schema = await getGraphqlSchemaFromApiUrl(apiUrl, schemaPath);
    graphqlSchemaMap[apiUrl] = schema;
    final enums = schema.enums.map((e) => _convertGEnumToDEnum(e)).join("\n");
    final inputs = schema.inputObjectTypes
        .map((e) => _convertGInputTypeToDType(e))
        .join("\n");
    schema.inputObjectTypes;
    return """
      
      $enums 

      $inputs
    
    """;
  }
}

enum Sample { hello }

String _convertGEnumToDEnum(gschema.EnumTypeDefinition genum) {
  final name = genum.name;
  final values = genum.values.map((v) => v.name).join(", ");
  final result = "enum $name { $values }";
  return result;
}

String _convertGInputTypeToDType(gschema.InputObjectTypeDefinition it) {
  final name = it.name;
  final fields = it.fields.map((gf) {
    final name = gf.name;
    final gtype = gf.type;
    var type = gtype.baseTypeName;
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

  return """
   @JsonSerializable(createFactory: false)
   class  $name {
     ${ModelUtils.getFinalFieldsFromFieldsList(fields)}

     ${ModelUtils.createConstructorFromFieldsList(name, fields)}
      
     ${ModelUtils.createToJson(name)} 
     
     ${ModelUtils.createCopyWithFromFieldsList(name, fields)}

     ${ModelUtils.createEqualsFromFieldsList(name, fields)}

     ${ModelUtils.createHashcodeFromFieldsList(fields)}

     ${ModelUtils.createToStringFromFieldsList(name, fields)}
   }
  """;
}

Future<gschema.GraphQLSchema> getGraphqlSchemaFromApiUrl(
    String url, String? schemaPath) async {
  late gschema.GraphQLSchema schema;
  try {
    final dio = Dio();
    final resp = await dio.post(url, data: {"query": getIntrospectionQuery()});
    final respStr = jsonEncode(resp.data);
    // await File("schema.json").writeAsString(respStr);
    schema = buildSchemaFromIntrospection(
        IntrospectionQuery.fromJson(resp.data["data"]));
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
