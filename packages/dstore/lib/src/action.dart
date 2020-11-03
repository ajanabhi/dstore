import 'package:dstore/src/http.dart';
import "package:meta/meta.dart";

@immutable
class Action {
  final String name;
  final String group;
  final Map<String, dynamic> payload;
  final HttpPayload http;
  final ActionInternal internal;

  const Action(
      {@required this.name,
      @required this.group,
      this.payload,
      this.http,
      this.internal});

  Action copyWith(
      {String name,
      String group,
      dynamic payload,
      HttpPayload http,
      ActionInternal internal}) {
    return Action(
        name: name ?? this.name,
        group: group ?? this.group,
        payload: payload ?? this.payload,
        http: http ?? this.http,
        internal: internal ?? this.internal);
  }
}

@immutable
class ActionInternal {
  final bool processed;
  final dynamic data;

  ActionInternal({this.processed = false, this.data});

  ActionInternal copyWith({bool processed, dynamic data}) {
    return ActionInternal(
        processed: processed ?? this.processed, data: data ?? this.data);
  }
}
