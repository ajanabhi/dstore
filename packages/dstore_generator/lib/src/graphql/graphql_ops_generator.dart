import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:dstore/dstore.dart';
import 'package:dstore_generator/src/graphql/globals.dart';
import 'package:dstore_generator/src/graphql/introspection.dart';
import 'package:dstore_generator/src/graphql/schema_generator.dart';
import 'package:dstore_generator/src/graphql/typegen.dart';
import 'package:gql/ast.dart';
import 'package:gql/schema.dart';
import 'package:source_gen/source_gen.dart';
import "package:gql/language.dart" as lang;

class GraphqlOpsGenerator extends GeneratorForAnnotation<GraphqlOps> {
  @override
  Future<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    if (!(element is ClassElement)) {
      throw Exception(
          "Graphqlops annotation should should only be applied on abstract classes");
    }
    final name = element.name;
    print("OpsName $name fields ${element.fields}");
    element.fields.forEach((f) {
      print("${f.name} ${f.isStatic} ${f.isConst}");
    });
    final opsAnnotations = element.metadata.first.computeConstantValue();
    final api = opsAnnotations.getField("api");
    final apiUrl = api.getField("apiUrl").toStringValue();
    final schemaPath = api.getField("schemaPath")?.toStringValue();
    GraphQLSchema schema;

    final eSchema = graphqlSchemaMap[apiUrl];
    if (eSchema == null) {
      schema = await getGraphqlSchemaFromApiUrl(apiUrl, schemaPath);
    } else {
      schema = eSchema;
    }
    print("Api Type ${api}");
    final ops = element.fields.where((f) => f.isStatic && f.isConst).map((e) {
      final v = e.computeConstantValue();
      var result = "";
      if (v.type.toString() == "String") {
        final query = v.toStringValue();
        final doc = lang.parseString(query);
        final dupOpsVisitor = DuplicateOperationVisitor(doc, schema);
        if (dupOpsVisitor.opType != null) {
          if (dupOpsVisitor.isMultipleOpsExist) {
            throw Exception(
                " You should specify only single query or mutation or subscription , not combined ops");
          }
          final tn = "${name}_${e.name}";
          result = generateOpsTypeForQuery(
              schema: schema, query: query, doc: doc, url: apiUrl, name: tn);
        }
      }
      print("opsvalue $v ${v.type}");

      return result;
    }).join("\n");
    print("opso $ops");
    return """
     $ops
    """;
  }
}

String generateOpsTypeForQuery(
    {required GraphQLSchema schema,
    required String query,
    required DocumentNode doc,
    required String url,
    required String name}) {
  final visitor = OperationVisitor(documentNode: doc, schema: schema);
  final types = getTypes(visitor, name);
  var result = "";
  if (visitor.opType == OperationType.query ||
      visitor.opType == OperationType.mutation) {
    final req = """
   @HttpRequest(
    method: "POST",
    url: "$url",
    graphqlQuery: "$query"
    responseType: HttpResponseType.JSON,
    inputType: HttpInputType.JSON,
    responseDeserializer: getTodosSerializer)
  """;
    final inputType =
        "GraphqlRequestInput${visitor.variables.isNotEmpty ? "<${name}Variables>" : ""}";

    result = """
    $types    

    $req
    class $name = HttpField<Null, $inputType, ${name}Data, dynamic> with EmptyMixin;

    $req
    class ${name}T<T> = HttpField<Null, $inputType, T, dynamic> with EmptyMixin;
  """;
  } else {}

  return result;
}
