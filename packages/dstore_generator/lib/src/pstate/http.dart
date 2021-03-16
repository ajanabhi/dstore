import 'package:analyzer/dart/element/element.dart';
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
  final type = element.type;

  final ht = AstUtils.isSubTypeof(type, "HttpField");
  if (ht == null) {
    return null;
  }
  if (ht.typeArguments.length != 4) {
    throw ArgumentError.value(
        "You should specify all 4 generic types of HttpField");
  }
  String? queryParamsType = replaceEndStar(
      ht.typeArguments[0].getDisplayString(withNullability: true));
  print("queryParamsType $queryParamsType");
  if (queryParamsType == "Null") {
    queryParamsType = null;
  }
  String? inputType = replaceEndStar(
      ht.typeArguments[1].getDisplayString(withNullability: true));
  if (inputType == "Null") {
    inputType = null;
  }
  final responseType = replaceEndStar(
      ht.typeArguments[2].getDisplayString(withNullability: true));
  final errorType = replaceEndStar(
      ht.typeArguments[3].getDisplayString(withNullability: true));
  final anot = type.element?.annotationFromType(HttpRequest);
  if (anot == null) {
    throw ArgumentError.value(
        "You should anotate type ${type} with HttpRequest");
  }
  final reader = ConstantReader(anot.computeConstantValue());
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
  final graphqlQuery = reader.peek("graphqlQuery")?.stringValue;
  final inputSerializer = reader.functionNameForField("inputSerializer");
  final responseSerializer = reader.functionNameForField("responseSerializer");
  final inputDeserializer = reader.functionNameForField("inputDeserializer");
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
      inputTypeEnum: inputTypeEnum,
      responseTypeEnum: responseTypeEnum!,
      inputDeserializer: inputDeserializer,
      responseSerializer: responseSerializer,
      inputType: inputType,
      responseDeserializer: responseDeserializer,
      errorDeserializer: errorDeserializer,
      queryParamsType: queryParamsType,
      inputSerializer: inputSerializer,
      responseType: responseType,
      transformer: transformer,
      graphqlQuery: graphqlQuery);
}

String convertHttpFieldInfoToAction(
    {required HttpFieldInfo hf, required String type}) {
  final params = <String>[];
  final payloadFields = <String>[];
  if (hf.queryParamsType != null) {
    params.add("required ${hf.queryParamsType} queryParams");
    payloadFields.add(
        "queryParams: ${hf.queryParamsType!.startsWith("Map<") ? "queryParams" : "queryParams.toMap()"}");
  }
  if (hf.inputType != null) {
    if (hf.inputType!.startsWith("GraphqlRequestInput")) {
      final it = hf.inputType!;
      final query = hf.graphqlQuery!;
      final variableType = it.contains("<")
          ? it.substring(it.indexOf("<"), it.indexOf(">"))
          : null;
      if (variableType != null) {
        params.add("required ${variableType} variables");
        payloadFields.add("input: GraphqlRequestInput(\"$query\",variables)");
      } else {
        payloadFields.add("input: GraphqlRequestInput(\"$query\",null)");
      }
    } else {
      params.add("required ${hf.inputType} input");
      payloadFields.add("input:input");
    }
  }
  params.add("bool abortable = false");
  payloadFields.add("abortable: abortable");
  params.add("bool offline = false");
  payloadFields.add("offline: offline");
  params.add("Map<String,dynamic>? headers");
  payloadFields.add("headers:headers");
  params.add("${hf.responseType} optimisticResponse");
  payloadFields.add("optimisticResponse:optimisticResponse");
  payloadFields.add("""url:"${hf.url}" """);
  payloadFields.add("""method: "${hf.method}" """);
  payloadFields.add("inputType:${hf.inputTypeEnum}");
  payloadFields.add("responseType:${hf.responseTypeEnum}");

  params.add("Duration? debounce");
  return """
      static ${hf.name}({${params.join(", ")}}) {
        return Action(name:"${hf.name}",type:"${type}",http:HttpPayload(${payloadFields.join(", ")}),debounce:debounce);
      }
    """;
}
