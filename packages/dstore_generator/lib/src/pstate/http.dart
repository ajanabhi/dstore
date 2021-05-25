import 'dart:convert';

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:dstore_annotation/dstore_annotation.dart';
import 'package:dstore_generator/src/pstate/types.dart';
import 'package:dstore_generator/src/utils/utils.dart';
import 'package:source_gen/source_gen.dart';

List<HttpFieldInfo> getHttpFields(List<FieldElement> fields) {
  final result = <HttpFieldInfo>[];
  fields.forEach((f) {
    final hf = _getHttpFieldInfo(f);
    if (hf != null) {
      result.add(hf);
    }
  });
  return result;
}

HttpFieldInfo? _getHttpFieldInfo(FieldElement element) {
  var ht = element.type;
  print(
      "Getting http for field ${element.type} ${element.type.runtimeType} Alias ${element.type.aliasElement}");
  // final ht = AstUtils.isSubTypeof(type, "HttpField");
  if (!ht.toString().startsWith("HttpField<")) {
    return null;
  }
  ht = ht as InterfaceType;
  if (ht.typeArguments.length != 3) {
    throw ArgumentError.value(
        "You should specify all 3 generic types of HttpField");
  }

  String? inputType = replaceEndStar(
      ht.typeArguments[0].getDisplayString(withNullability: true));
  final responseType = replaceEndStar(
      ht.typeArguments[1].getDisplayString(withNullability: true));
  final errorType = replaceEndStar(
      ht.typeArguments[2].getDisplayString(withNullability: true));
  final anot = element.type.aliasElement?.annotationFromType(HttpRequest);
  if (anot == null) {
    throw ArgumentError.value("You should anotate type ${ht} with HttpRequest");
  }
  print("HttpRequest Anotation ${anot.toSource()}");
  final value = anot.computeConstantValue();
  final reader = ConstantReader(value);
  final url = reader.read("url").stringValue;
  final method = reader.read("method").stringValue;
  var responseTypeEnum =
      reader.getEnumField("responseType", HttpResponseType.values);
  if (responseTypeEnum == null) {
    if (responseType == "String") {
      responseTypeEnum = HttpResponseType.STRING;
    } else if (responseType != "Null") {
      responseTypeEnum = HttpResponseType.JSON;
    }
  }
  final queryParamsType = reader.peek("queryParamsType")?.stringValue;
  final pathParamsType = reader.peek("pathParamsType")?.stringValue;
  var inputTypeEnum = reader.getEnumField("inputType", HttpInputType.values);
  if (inputTypeEnum == null) {
    if (inputType == "String") {
      inputTypeEnum = HttpInputType.TEXT;
    } else {
      inputTypeEnum = HttpInputType.JSON;
    }
  }

  var responseDeserializer =
      reader.functionNameForField("responseDeserializer") ?? "IdentifyFn";
  var errorDeserializer =
      reader.functionNameForField("errorDeserializer") ?? "IdentifyFn";
  final graphqlQuery = getGraphqlRequestPartFromDartObj(
      reader.peek("graphqlQuery")?.objectValue);
  final inputSerializer = reader.functionNameForField("inputSerializer");
  final responseSerializer = reader.functionNameForField("responseSerializer");
  final inputDeserializer = reader.functionNameForField("inputDeserializer");
  final headersMap = reader.getStringMapForField("headers");
  final headers = headersMap != null ? jsonEncode(headersMap) : null;
  final reqExtAnnot = element.annotationFromType(HttpRequestExtension);

  String? transformer;
  if (reqExtAnnot != null) {
    final reqE = ConstantReader(reqExtAnnot.computeConstantValue());
    transformer = reqE.functionNameForField("transformer");
  }

  return HttpFieldInfo(
      name: element.name,
      url: url,
      method: method,
      headers: headers,
      fieldType: element.type.toString(),
      inputTypeEnum: inputTypeEnum,
      responseTypeEnum: responseTypeEnum!,
      inputDeserializer: inputDeserializer,
      responseSerializer: responseSerializer,
      inputType: inputType,
      errorType: errorType,
      responseDeserializer: responseDeserializer,
      errorDeserializer: errorDeserializer,
      queryParamsType: queryParamsType,
      inputSerializer: inputSerializer,
      responseType: responseType,
      pathParamsType: pathParamsType,
      transformer: transformer,
      graphqlQuery: graphqlQuery);
}

GraphqlRequestPart? getGraphqlRequestPartFromDartObj(
    DartObject? graphqlQueryObj) {
  if (graphqlQueryObj != null) {
    final query = graphqlQueryObj.getField("query")!.toStringValue()!;
    final hash = graphqlQueryObj.getField("hash")?.toStringValue();
    final useGetForPersist =
        graphqlQueryObj.getField("useGetForPersist")?.toBoolValue();
    return GraphqlRequestPart(
        query: query, hash: hash, useGetForPersist: useGetForPersist ?? false);
  }
}

String convertHttpFieldInfoToAction(
    {required HttpFieldInfo hf,
    required String type,
    required String modelName}) {
  final params = <String>[];
  final payloadFields = <String>[];
  if (hf.queryParamsType != null) {
    params.add("required ${hf.queryParamsType} queryParams");
    payloadFields.add(
        "queryParams: ${hf.queryParamsType!.startsWith("Map<") ? "queryParams" : "queryParams.toMap()"}");
  }
  if (hf.inputType != "Null") {
    if (hf.inputType!.startsWith("GraphqlRequestInput")) {
      final it = hf.inputType!;

      final graphqlQueryPart = hf.graphqlQuery!;
      final gparams = <String>[
        "query: ${graphqlQueryPart.query.addTripleQuotes}"
      ];
      if (graphqlQueryPart.hash != null) {
        final extensions = {
          "persistedQuery": {"version": 1, "sha256Hash": graphqlQueryPart.hash}
        };
        gparams.add("extensions: ${extensions}");
      }
      if (graphqlQueryPart.useGetForPersist) {
        gparams.add("useGetForPersitent: true");
      }
      final variableType = it.contains("<")
          ? it.substring(it.indexOf("<") + 1, it.indexOf(">"))
          : null;
      if (variableType != null &&
          variableType != "dynamic" &&
          variableType != "Null") {
        params.add("required ${variableType} variables");
        gparams.add("variables: variables");
      }
      payloadFields.add("data: GraphqlRequestInput(${gparams.join(", ")})");
    } else {
      params.add("required ${hf.inputType} input");
      payloadFields.add("data:input");
    }
  }
  params.add("bool abortable = false");
  params.add("bool silent = false");
  payloadFields.add("abortable: abortable");
  params.add("bool offline = false");
  payloadFields.add("offline: offline");
  params.add("Map<String,dynamic>? headers");
  payloadFields.add("headers:headers");
  params.add("${hf.responseType}? optimisticResponse");
  payloadFields.add("optimisticResponse:optimisticResponse");
  payloadFields.add("""url:"${hf.url}" """);
  payloadFields.add("""method: "${hf.method}" """);
  payloadFields.add("responseType:${hf.responseTypeEnum}");
  final qpType = hf.queryParamsType ?? "Null";
  final ppType = hf.pathParamsType ?? "Null";
  final mockType = hf.fieldType.endsWith("?")
      ? hf.fieldType.replaceAll("?", "")
      : hf.fieldType;
  params.add("$mockType? mock");
  params.add("Duration? debounce");
  final mergeHeaders = hf.headers != null
      ? "headers = <String,dynamic>{...<String,String>${hf.headers},...headers ?? <String,String>{}};"
      : "";
  return """
      static Action<${mockType}> ${hf.name}({${params.join(", ")}}) {
        $mergeHeaders
        return Action<$mockType>(name:"${hf.name}",type:${type},silent:silent,http:HttpPayload<${ppType},${qpType},${hf.inputType},${hf.responseType},${hf.errorType},dynamic>(${payloadFields.join(", ")}),debounce:debounce);
      }

      static Action<${mockType}> ${hf.name}Mock($mockType mock) {
        return Action<$mockType>(name:"${hf.name}",type:${type},mock:mock);
      }
    """;
}
