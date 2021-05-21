import 'package:dstore/dstore.dart';
import 'package:dstore/src/http.dart';
import 'package:dstore/src/nav.dart';
import 'package:dstore/src/stream.dart';
import 'package:dstore/src/utils/utils.dart';
import 'package:dstore/src/websocket.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:dstore_annotation/dstore_annotation.dart';

part "action.dstore.dart";

@dimmutable
@optionalTypeArgs
abstract class Action<M> with _$Action<M> {
  const factory Action({
    required String name,
    required String type,
    @Default(false) bool isAsync,
    NavPayload? nav,
    Map<String, dynamic>? payload,
    HttpPayload? http,
    WebSocketPayload<dynamic, dynamic, dynamic>? ws,
    @Default(null) dynamic? extra,
    ActionInternal? internal,
    StreamPayload? stream,
    Duration? debounce,
    void Function(PStateModel state)? afterSilent,
    @Default(false) bool silent,
    M? mock,
    FormReq? form,
  }) = _Action<M>;

  factory Action.fromJson(Map<String, dynamic> map, HttpMeta? httpMeta) {
    final name = map["name"] as String;
    final type = map["type"] as String;
    final httpMap = map["http"] as Map<String, dynamic>?;
    HttpPayload? http;
    if (httpMap != null) {
      if (httpMeta == null) {
        throw ArgumentError.value(
            "You should provide httpMeta for http actions");
      }
      http = HttpPayload<dynamic, dynamic, dynamic, dynamic, dynamic,
          dynamic>.fromJson(httpMap, httpMeta);
    }
    return Action<M>(name: name, type: type, http: http);
  }
}

extension ActionExt on Action {
  bool get isProcessed => internal?.processed ?? false;
  // currently only http actions support offline functionality
  Map<String, dynamic> toJson({HttpMeta? httpMeta}) {
    final map = <String, dynamic>{};
    if (http != null && httpMeta == null) {
      throw ArgumentError.value(
          "You should provide httpmeta if action has http field");
    }
    map["name"] = name;
    map["type"] = type;
    map["http"] = http?.toJson(httpMeta!);
    return map;
  }

  String get id => "$type.$name";
}

@dimmutable
abstract class ActionInternal with _$ActionInternal {
  const factory ActionInternal({
    required bool processed,
    required ActionInternalType type,
    required dynamic data,
  }) = _ActionInternal;
}

enum ActionInternalType { FIELD, PSTATE }
