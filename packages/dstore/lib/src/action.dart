import 'package:dstore/dstore.dart';
import 'package:dstore/src/http.dart';
import 'package:dstore/src/websocket.dart';
import 'package:dstore_annotation/dstore_annotation.dart';

part "action.dstore.dart";

@dimmutable
abstract class Action with _$Action {
  const factory Action({
    required String name,
    required Type type,
    @Default(false) bool isAsync,
    Map<String, dynamic>? payload,
    HttpPayload? http,
    WebSocketPayload? ws,
    dynamic? extra,
    ActionInternal? internal,
    Stream? stream,
    Duration? debounce,
    FormReq? form,
  }) = _Action;
}

extension ActionExt on Action {
  bool get isProcessed => internal?.processed ?? false;
}

@dimmutable
abstract class ActionInternal with _$ActionInternal {
  const factory ActionInternal({
    required bool processed,
    required ActionInternalType type,
    required dynamic data,
  }) = _ActionInternal;
}

enum ActionInternalType { DATA, STATE }
