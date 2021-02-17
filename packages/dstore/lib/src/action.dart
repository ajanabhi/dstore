import 'package:dstore/dstore.dart';
import 'package:dstore/src/http.dart';
import 'package:dstore/src/websocket.dart';
import "package:meta/meta.dart";

@immutable
class Action {
  final String name;
  final int group;
  final bool isAsync;
  final Map<String, dynamic>? payload;
  final HttpPayload? http;
  final WebSocketPayload? ws;
  final dynamic? extra;
  final ActionInternal? internal;
  final Stream? stream;
  final FormReq? form;

  const Action(
      {required this.name,
      required this.group,
      this.isAsync = false,
      this.stream,
      this.payload,
      this.ws,
      this.extra,
      this.http,
      this.form,
      this.internal});

  Action copyWith(
      {String? name,
      int? group,
      dynamic? payload,
      dynamic? extra,
      Stream? stream,
      HttpPayload? http,
      WebSocketPayload? ws,
      FormReq? form,
      ActionInternal? internal}) {
    return Action(
        name: name ?? this.name,
        group: group ?? this.group,
        payload: payload ?? this.payload,
        http: http ?? this.http,
        extra: extra ?? this.extra,
        form: form ?? this.form,
        ws: ws ?? this.ws,
        stream: stream ?? this.stream,
        internal: internal ?? this.internal);
  }

  bool get isProcessed => internal?.processed ?? false;
}

@immutable
class ActionInternal {
  final bool processed;
  final ActionInternalType type;
  final dynamic data;

  ActionInternal(
      {this.processed = false, required this.data, required this.type});

  ActionInternal copyWith(
      {bool? processed, dynamic data, ActionInternalType? type}) {
    return ActionInternal(
        processed: processed ?? this.processed,
        type: type ?? this.type,
        data: data ?? this.data);
  }
}

enum ActionInternalType { DATA, STATE }
