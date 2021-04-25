import 'package:dstore_generator/src/graphql/globals.dart';
import 'package:gql/schema.dart';

abstract class GraphqlAstUtils {
  static TypeDefinition getTypeDefinitionFromGraphqlType(GraphQLType gt) {
    if (gt is NamedType) {
      return gt.type;
    } else {
      return getTypeDefinitionFromGraphqlType((gt as ListType).type);
    }
  }

  static String getObjectQuery(
      {required String objectName, required String apiUrl}) {
    final existingValue = graphqlObjectsQueryExpansionMap[apiUrl]?[objectName];
    if (existingValue != null) {
      return existingValue;
    }
    final schema = graphqlSchemaMap[apiUrl]!;
    final td = schema.typeMap[objectName];
    final query =
        convertObjectDefnitionToQueryString(td as ObjectTypeDefinition);
    final existingMap = graphqlObjectsQueryExpansionMap[apiUrl];
    if (existingMap != null) {
      existingMap[objectName] = query;
    } else {
      graphqlObjectsQueryExpansionMap[apiUrl] = {objectName: query};
    }
    return query;
  }

  static String convertObjectDefnitionToQueryString(ObjectTypeDefinition otd) {
    return otd.fields.map((e) {
      final name = e.name;
      final td = getTypeDefinitionFromGraphqlType(e.type);
      if (td is ScalarTypeDefinition) {
        return name;
      } else if (td is ObjectTypeDefinition) {
        return """$name {
             ${convertObjectDefnitionToQueryString(td)}
          } """;
      } else {
        return "";
      }
    }).join("\n");
  }
}
