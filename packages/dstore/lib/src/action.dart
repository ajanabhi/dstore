import 'package:dstore/src/http.dart';
import "package:meta/meta.dart";

@immutable
class Action {
  final String name;
  final String group;
  final bool isAsync;
  final Map<String, dynamic> payload;
  final HttpPayload http;
  final dynamic extra;
  final ActionInternal internal;
  final Stream stream;

  const Action(
      {@required this.name,
      @required this.group,
      this.isAsync = false,
      this.stream,
      this.payload,
      this.extra,
      this.http,
      this.internal});

  Action copyWith(
      {String name,
      String group,
      dynamic payload,
      dynamic extra,
      Stream stream,
      HttpPayload http,
      ActionInternal internal}) {
    return Action(
        name: name ?? this.name,
        group: group ?? this.group,
        payload: payload ?? this.payload,
        http: http ?? this.http,
        extra: extra ?? this.extra,
        stream: stream ?? this.stream,
        internal: internal ?? this.internal);
  }

  bool get isProcessed => this.internal != null && this.internal.processed;
}

@immutable
class ActionInternal {
  final bool processed;
  final ActionInternalType type;
  final dynamic data;

  ActionInternal(
      {this.processed = false, @required this.data, @required this.type});

  ActionInternal copyWith(
      {bool processed, dynamic data, ActionInternalType type}) {
    return ActionInternal(
        processed: processed ?? this.processed,
        type: type ?? this.type,
        data: data ?? this.data);
  }
}

enum ActionInternalType { DATA, STATE }
