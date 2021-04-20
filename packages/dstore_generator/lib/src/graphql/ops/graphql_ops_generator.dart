import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:dstore_annotation/dstore_annotation.dart';
import 'package:dstore_generator/src/graphql/globals.dart';
import 'package:dstore_generator/src/graphql/ops/typegen.dart';
import 'package:dstore_generator/src/graphql/schema/schema_genrator.dart';
import 'package:dstore_generator/src/utils/utils.dart';
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
    final apiA = opsAnnotations?.getField("api")!;
    final gAPi = getGraphqlApi(apiA);
    final apiUrl = gAPi.apiUrl;
    GraphQLSchema schema;

    final eSchema = graphqlSchemaMap[apiUrl];
    if (eSchema == null) {
      schema = await getGraphqlSchemaFromApiUrl(gAPi);
    } else {
      schema = eSchema;
    }
    print("Api Type ${gAPi}");
    final ops = element.fields.where((f) => f.isStatic && f.isConst).map((e) {
      final v = e.computeConstantValue()!;
      var result = "";
      logger.shout("Value $v");
      if (v.type.toString() == "String") {
        final query = v.toStringValue();
        final doc = lang.parseString(query);
        final dupOpsVisitor = DuplicateOperationVisitor(doc, schema);
        doc.accept(dupOpsVisitor);
        if (dupOpsVisitor.opType != null) {
          if (dupOpsVisitor.isMultipleOpsExist) {
            throw Exception(
                " You should specify only single query or mutation or subscription , not combined ops");
          }
          final tn = "${name}_${e.name}";
          logger.shout("TN $tn");
          result = generateOpsTypeForQuery(
              schema: schema,
              query: query!,
              doc: doc,
              url: apiUrl,
              name: tn,
              api: gAPi);
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
    required GraphqlApi api,
    required String name}) {
  final visitor = OperationVisitor(documentNode: doc, schema: schema, api: api);
  doc.accept(visitor);
  final types = getTypes(visitor, name);
  var result = "";
  if (visitor.opType == OperationType.query ||
      visitor.opType == OperationType.mutation) {
    final req = """
   @HttpRequest(
    method: "POST",
    url: "$url",
    graphqlQuery: \"\"\"$query\"\"\",
    responseType: HttpResponseType.JSON,
    headers: {"Content_Type":"applications/josn"},
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
