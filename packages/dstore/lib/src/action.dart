import 'package:dstore/dstore.dart';
import 'package:dstore/src/http.dart';
import 'package:dstore/src/utils.dart';
import 'package:dstore/src/websocket.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:dstore_annotation/dstore_annotation.dart';

part "action.dstore.dart";

abstract class ToMap {
  Map<String, dynamic> toMap();
}

@dimmutable
abstract class Action<M extends ToMap> with _$Action<M> {
  const factory Action({
    required String name,
    required String type,
    @Default(false) bool isAsync,
    Map<String, dynamic>? payload,
    HttpPayload? http,
    WebSocketPayload? ws,
    @Default(null) dynamic? extra,
    ActionInternal? internal,
    Stream? stream,
    Duration? debounce,
    M? mock,
    FormReq? form,
  }) = _Action<M>;

  factory Action.fromJson(Map<String, dynamic> map, Httpmeta? httpMeta) {
    final name = map["name"];
    final type = map["type"];
    var http = map["http"];
    if (http != null) {
      if (httpMeta == null) {
        throw ArgumentError.value(
            "You should provide httpMeta for http actions");
      }
      http = HttpPayload.fromJson(http, httpMeta);
    }
    return Action(name: name, type: type, http: http);
  }
}

extension ActionExt on Action {
  bool get isProcessed => internal?.processed ?? false;
  // currently only http actions support offline functionality
  Map<String, dynamic> toJson({Httpmeta? httpMeta}) {
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
