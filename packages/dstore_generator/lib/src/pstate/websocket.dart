import 'package:analyzer/dart/element/element.dart';
import 'package:dstore_generator/src/pstate/types.dart';
import 'package:dstore_generator/src/utils/utils.dart';
import 'package:dstore_annotation/dstore_annotation.dart';

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
}
