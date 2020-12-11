import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:dstore/dstore.dart';
import 'package:dstore_generator/src/graphql/globals.dart';
import 'package:dstore_generator/src/utils.dart';
import 'package:gql/language.dart' as glang;
import 'package:gql/schema.dart' as gschema;
import 'package:source_gen/source_gen.dart';
import "dart:io";

class GraphlSchemaGenerator extends GeneratorForAnnotation<GraphqlApi> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    if (!(element is ClassElement)) {
      throw Exception(
          "Graphql Api annotation should only be applied on classes");
    }

    final gApi = element.metadata.first.computeConstantValue();
    final apiUrl = gApi.getField("apiUrl").toStringValue();
    final schemaPath = gApi.getField("schemaPath").toStringValue();
    String? wsUrl;
    final wsUrlField = gApi.getField("wsUrl");
    if (!wsUrlField.isNull) {
      wsUrl = wsUrlField.toStringValue();
    }
    final schemaStr = await File(schemaPath).readAsString();
    final schemaDoc = glang.parseString(schemaStr);
    final schema = gschema.GraphQLSchema.fromNode(schemaDoc);
    graphqlSchemaMap[apiUrl] = schema;
    final enums = schema.enums.map((e) => _convertGEnumToDEnum(e)).join("\n");
    schema.inputObjectTypes;
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
     ${getFinalFieldsFromFieldsList(fields)}

     ${createConstructorFromFieldsList(name, fields)}
      
     ${createToJson(name)} 
     
     ${createCopyWithFromFieldsList(name, fields)}

     ${createEqualsFromFieldsList(name, fields)}

     ${createHashcodeFromFieldsList(fields)}

     ${createToStringFromFieldsList(name, fields)}
   }
  """;
}
