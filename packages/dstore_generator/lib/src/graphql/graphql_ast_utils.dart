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
    return otd.fields.map((e) {}).join("\n");
  }

  static String convertFieldDefinitionToQueryString(FieldDefinition fd) {
    final name = fd.name;
    final td = getTypeDefinitionFromGraphqlType(fd.type);
    if (td is ScalarTypeDefinition) {
      return name;
    } else if (td is ObjectTypeDefinition) {
      return """$name {
             ${convertObjectDefnitionToQueryString(td)}
          } """;
    } else if (td is UnionTypeDefinition) {
      return """
          $name {
            ${convertUnionTypeDefnitionToQueryString(td)}
          }
        """;
    } else if (td is InterfaceTypeDefinition) {
      return """
          $name {
            ${convertInterfaceTypeDefinitionToQueryString(td)}
          }
        """;
    } else {
      return "";
    }
  }

  static String convertUnionTypeDefnitionToQueryString(UnionTypeDefinition ud) {
    final frags = ud.types.map((e) {
      return """
       on ${e.name} {
         ${convertObjectDefnitionToQueryString(e)}
       }
      """;
    });
    return """
       __typename
       $frags
     """;
  }

  static String convertInterfaceTypeDefinitionToQueryString(
      InterfaceTypeDefinition id) {
    final fields =
        id.fields.map((e) => convertFieldDefinitionToQueryString(e)).join("\n");
    //  final frags = id. //TODO may be get concrete types ?
    return """
     $fields
     __typename

    """;
  }
}
