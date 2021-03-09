import 'dart:collection';

import 'package:analyzer/dart/element/element.dart';
import 'package:dstore_generator/src/pstate/types.dart';
import 'package:dstore_generator/src/utils/utils.dart';
import 'package:dstore_annotation/dstore_annotation.dart';
import 'package:source_gen/source_gen.dart';

List<WebSocketFieldInfo> getWebSocketFields(List<FieldElement> fields) {
  final result = <WebSocketFieldInfo>[];
  fields.forEach((element) {
    final wsi = _getWebSocketFieldInfoForElement(element);
    if (wsi != null) {
      result.add(wsi);
    }
  });
  return result;
}

WebSocketFieldInfo? _getWebSocketFieldInfoForElement(FieldElement element) {
  final type = element.type;
  final wf = AstUtils.isSubTypeof(type, "WebSocketField");
  if (wf == null) {
    return null;
  }
  final typeParams = wf.typeArguments;
  if (typeParams.length != 3) {
    throw ArgumentError.value(
        "You should provide types all typeparams of WebSocketField");
  }
  final inputType = typeParams[0].getDisplayString(withNullability: true);
  final responseType = typeParams[1].getDisplayString(withNullability: true);
  final errorType = typeParams[1].getDisplayString(withNullability: true);
  final wsrAnot = type.element?.annotationFromType(WebSocketRequest);
  if (wsrAnot == null) {
    throw ArgumentError.value(
        "you should annotate $type with WebSocketRequest");
  }

  final reader = ConstantReader(wsrAnot.computeConstantValue());
  final url = reader.read("url").stringValue;
  final inputSerializerField = reader.read("inputSerializer");
  String? inputSerializer;
  if (inputSerializerField != null && !inputSerializerField.isNull) {
    inputSerializer = inputSerializerField.objectValue.toFunctionValue()!.name;
  }
  final responseDeserizerField = reader.read("responseDeserializer");
  String? responseDeserializer;
  if (responseDeserizerField != null && !responseDeserizerField.isNull) {
    responseDeserializer =
        responseDeserizerField.objectValue.toFunctionValue()!.name;
  }
  final graphqlQuery = reader.read("graphqlQuery")?.stringValue;
  final wseAnnot = element.annotationFromType(WebSocketRequestExtension);
  String? transofrmer;
  if (wseAnnot != null) {
    final reader = ConstantReader(wseAnnot.computeConstantValue());
    final transformerField = reader.read("transformer");
    if (transformerField != null && !transformerField.isNull) {
      transofrmer = transformerField.objectValue.toFunctionValue()?.name;
    }
  }
  return WebSocketFieldInfo(
      url: url,
      name: element.name,
      inputSerializer: inputSerializer,
      responseDeserializer: responseDeserializer,
      inputType: inputType,
      transformer: transofrmer,
      graphqlQuery: graphqlQuery);
}

String convertWebSocketFieldInfoToAction(
    {required WebSocketFieldInfo wsi, required String type}) {
  final name = wsi.name;
  final params = <String>[];
  final payloadParams = <String>[];
  payloadParams.add("url: ${wsi.url}");

  if (wsi.inputType.startsWith("GraphqlRequestInput")) {
    final it = wsi.inputType;
    final query = wsi.graphqlQuery!;
    final variableType = it.contains("<")
        ? it.substring(it.indexOf("<"), it.indexOf(">"))
        : null;
    if (variableType != null) {
      params.add("required ${variableType} variables");
      payloadParams.add("data: GraphqlRequestInput(\"$query\",variables)");
    } else {
      payloadParams.add("data: GraphqlRequestInput(\"$query\",null)");
    }
  } else {
    params.add("${wsi.inputType} data");
    payloadParams.add("data: data");
  }

  payloadParams.add("responseDeserializer: ${wsi.responseDeserializer}");
  payloadParams.add("inputSerializer: ${wsi.inputSerializer}");
  payloadParams.add("transformer: ${wsi.transformer}");

  params.add("Map<String,dynamic>? headers");
  payloadParams.add("headers:headers");

  params.add("bool unsubscribe = false");
  payloadParams.add("unsubscribe: unsubscribe");

  return """
    static Action ${wsi.name}(${params.join(", ")}) {
      return Action(name: "$name", type: $type, ws: WebSocketPayload(${payloadParams.join(",")}));
    }
   """;
}
