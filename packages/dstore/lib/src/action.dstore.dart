// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'action.dart';

// **************************************************************************
// DImmutableGenerator
// **************************************************************************

class Action<M> {
  final String name;

  final String type;

  final bool isAsync;

  final NavPayload? nav;

  final Map<String, dynamic>? payload;

  final HttpPayload? http;

  final WebSocketPayload<dynamic, dynamic, dynamic>? ws;

  final dynamic? extra;

  final ActionInternal? internal;

  final StreamPayload? stream;

  final Duration? debounce;

  final void Function(PStateModel state)? afterSilent;

  final bool silent;

  final M? mock;

  final FormReq? form;

  final DateTime? offlinedAt;

  _$ActionCopyWith<M, Action<M>> get copyWith =>
      __$ActionCopyWithImpl<M, Action<M>>(this, IdentityFn);

  const Action(
      {required this.name,
      required this.type,
      this.isAsync = false,
      this.nav,
      this.payload,
      this.http,
      this.ws,
      this.extra,
      this.internal,
      this.stream,
      this.debounce,
      this.afterSilent,
      this.silent = false,
      this.mock,
      this.form,
      this.offlinedAt});

  bool get isProcessed => internal?.processed ?? false;
  Map<String, dynamic> toJson({HttpMeta? httpMeta}) {
    final map = <String, dynamic>{};
    if (http != null && httpMeta == null) {
      throw ArgumentError.value(
          "You should provide httpmeta if action has http field");
    }
    map["name"] = name;
    map["type"] = type;
    map["http"] = http?.toJson(httpMeta!);
    map["offlinedAt"] = offlinedAt?.millisecondsSinceEpoch;
    return map;
  }

  String get id => "$type.$name";
  static Action fromJson<M>(Map<String, dynamic> map, HttpMeta? httpMeta) {
    final name = map["name"] as String;
    final type = map["type"] as String;
    final offlinedAtInt = map["offlinedAt"] as int?;
    final offlinedAt = offlinedAtInt != null
        ? DateTime.fromMillisecondsSinceEpoch(offlinedAtInt)
        : null;
    final httpMap = map["http"] as Map<String, dynamic>?;
    HttpPayload? http;
    if (httpMap != null) {
      if (httpMeta == null) {
        throw ArgumentError.value(
            "You should provide httpMeta for http actions");
      }
      http = HttpPayload.fromJson<dynamic, dynamic, dynamic, dynamic, dynamic,
          dynamic>(httpMap, httpMeta);
    }
    return Action<M>(
        name: name, type: type, http: http, offlinedAt: offlinedAt);
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is Action &&
        o.name == name &&
        o.type == type &&
        o.isAsync == isAsync &&
        o.nav == nav &&
        o.payload == payload &&
        o.http == http &&
        o.ws == ws &&
        o.extra == extra &&
        o.internal == internal &&
        o.stream == stream &&
        o.debounce == debounce &&
        o.afterSilent == afterSilent &&
        o.silent == silent &&
        o.mock == mock &&
        o.form == form &&
        o.offlinedAt == offlinedAt;
  }

  @override
  int get hashCode =>
      name.hashCode ^
      type.hashCode ^
      isAsync.hashCode ^
      nav.hashCode ^
      payload.hashCode ^
      http.hashCode ^
      ws.hashCode ^
      extra.hashCode ^
      internal.hashCode ^
      stream.hashCode ^
      debounce.hashCode ^
      afterSilent.hashCode ^
      silent.hashCode ^
      mock.hashCode ^
      form.hashCode ^
      offlinedAt.hashCode;

  @override
  String toString() =>
      "Action(name: ${this.name}, type: ${this.type}, isAsync: ${this.isAsync}, nav: ${this.nav}, payload: ${this.payload}, http: ${this.http}, ws: ${this.ws}, extra: ${this.extra}, internal: ${this.internal}, stream: ${this.stream}, debounce: ${this.debounce}, afterSilent: ${this.afterSilent}, silent: ${this.silent}, mock: ${this.mock}, form: ${this.form}, offlinedAt: ${this.offlinedAt})";
}

abstract class $ActionCopyWith<M, O> {
  factory $ActionCopyWith(Action<M> value, O Function(Action<M>) then) =
      _$ActionCopyWithImpl<M, O>;
  O call(
      {String name,
      String type,
      bool isAsync,
      NavPayload? nav,
      Map<String, dynamic>? payload,
      HttpPayload? http,
      WebSocketPayload<dynamic, dynamic, dynamic>? ws,
      dynamic? extra,
      ActionInternal? internal,
      StreamPayload? stream,
      Duration? debounce,
      void Function(PStateModel state)? afterSilent,
      bool silent,
      M? mock,
      FormReq? form,
      DateTime? offlinedAt});
}

class _$ActionCopyWithImpl<M, O> implements $ActionCopyWith<M, O> {
  final Action<M> _value;
  final O Function(Action<M>) _then;
  _$ActionCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? name = dimmutable,
      Object? type = dimmutable,
      Object? isAsync = dimmutable,
      Object? nav = dimmutable,
      Object? payload = dimmutable,
      Object? http = dimmutable,
      Object? ws = dimmutable,
      Object? extra = dimmutable,
      Object? internal = dimmutable,
      Object? stream = dimmutable,
      Object? debounce = dimmutable,
      Object? afterSilent = dimmutable,
      Object? silent = dimmutable,
      Object? mock = dimmutable,
      Object? form = dimmutable,
      Object? offlinedAt = dimmutable}) {
    return _then(_value.copyWith(
        name: name == dimmutable ? _value.name : name as String,
        type: type == dimmutable ? _value.type : type as String,
        isAsync: isAsync == dimmutable ? _value.isAsync : isAsync as bool,
        nav: nav == dimmutable ? _value.nav : nav as NavPayload?,
        payload: payload == dimmutable
            ? _value.payload
            : payload as Map<String, dynamic>?,
        http: http == dimmutable ? _value.http : http as HttpPayload?,
        ws: ws == dimmutable
            ? _value.ws
            : ws as WebSocketPayload<dynamic, dynamic, dynamic>?,
        extra: extra == dimmutable ? _value.extra : extra as dynamic?,
        internal: internal == dimmutable
            ? _value.internal
            : internal as ActionInternal?,
        stream: stream == dimmutable ? _value.stream : stream as StreamPayload?,
        debounce:
            debounce == dimmutable ? _value.debounce : debounce as Duration?,
        afterSilent: afterSilent == dimmutable
            ? _value.afterSilent
            : afterSilent as void Function(PStateModel state)?,
        silent: silent == dimmutable ? _value.silent : silent as bool,
        mock: mock == dimmutable ? _value.mock : mock as M?,
        form: form == dimmutable ? _value.form : form as FormReq?,
        offlinedAt: offlinedAt == dimmutable
            ? _value.offlinedAt
            : offlinedAt as DateTime?));
  }
}

abstract class _$ActionCopyWith<M, O> implements $ActionCopyWith<M, O> {
  factory _$ActionCopyWith(Action<M> value, O Function(Action<M>) then) =
      __$ActionCopyWithImpl<M, O>;
  O call(
      {String name,
      String type,
      bool isAsync,
      NavPayload? nav,
      Map<String, dynamic>? payload,
      HttpPayload? http,
      WebSocketPayload<dynamic, dynamic, dynamic>? ws,
      dynamic? extra,
      ActionInternal? internal,
      StreamPayload? stream,
      Duration? debounce,
      void Function(PStateModel state)? afterSilent,
      bool silent,
      M? mock,
      FormReq? form,
      DateTime? offlinedAt});
}

class __$ActionCopyWithImpl<M, O> extends _$ActionCopyWithImpl<M, O>
    implements _$ActionCopyWith<M, O> {
  __$ActionCopyWithImpl(Action<M> _value, O Function(Action<M>) _then)
      : super(_value, (v) => _then(v));

  @override
  Action<M> get _value => super._value;

  @override
  O call(
      {Object? name = dimmutable,
      Object? type = dimmutable,
      Object? isAsync = dimmutable,
      Object? nav = dimmutable,
      Object? payload = dimmutable,
      Object? http = dimmutable,
      Object? ws = dimmutable,
      Object? extra = dimmutable,
      Object? internal = dimmutable,
      Object? stream = dimmutable,
      Object? debounce = dimmutable,
      Object? afterSilent = dimmutable,
      Object? silent = dimmutable,
      Object? mock = dimmutable,
      Object? form = dimmutable,
      Object? offlinedAt = dimmutable}) {
    return _then(Action(
        name: name == dimmutable ? _value.name : name as String,
        type: type == dimmutable ? _value.type : type as String,
        isAsync: isAsync == dimmutable ? _value.isAsync : isAsync as bool,
        nav: nav == dimmutable ? _value.nav : nav as NavPayload?,
        payload: payload == dimmutable
            ? _value.payload
            : payload as Map<String, dynamic>?,
        http: http == dimmutable ? _value.http : http as HttpPayload?,
        ws: ws == dimmutable
            ? _value.ws
            : ws as WebSocketPayload<dynamic, dynamic, dynamic>?,
        extra: extra == dimmutable ? _value.extra : extra as dynamic?,
        internal: internal == dimmutable
            ? _value.internal
            : internal as ActionInternal?,
        stream: stream == dimmutable ? _value.stream : stream as StreamPayload?,
        debounce:
            debounce == dimmutable ? _value.debounce : debounce as Duration?,
        afterSilent: afterSilent == dimmutable
            ? _value.afterSilent
            : afterSilent as void Function(PStateModel state)?,
        silent: silent == dimmutable ? _value.silent : silent as bool,
        mock: mock == dimmutable ? _value.mock : mock as M?,
        form: form == dimmutable ? _value.form : form as FormReq?,
        offlinedAt: offlinedAt == dimmutable
            ? _value.offlinedAt
            : offlinedAt as DateTime?));
  }
}

class ActionInternal {
  final bool processed;

  final ActionInternalType type;

  final dynamic data;

  _$ActionInternalCopyWith<ActionInternal> get copyWith =>
      __$ActionInternalCopyWithImpl<ActionInternal>(this, IdentityFn);

  const ActionInternal(
      {required this.processed, required this.type, required this.data});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is ActionInternal &&
        o.processed == processed &&
        o.type == type &&
        o.data == data;
  }

  @override
  int get hashCode => processed.hashCode ^ type.hashCode ^ data.hashCode;

  @override
  String toString() =>
      "ActionInternal(processed: ${this.processed}, type: ${this.type}, data: ${this.data})";
}

abstract class $ActionInternalCopyWith<O> {
  factory $ActionInternalCopyWith(
          ActionInternal value, O Function(ActionInternal) then) =
      _$ActionInternalCopyWithImpl<O>;
  O call({bool processed, ActionInternalType type, dynamic data});
}

class _$ActionInternalCopyWithImpl<O> implements $ActionInternalCopyWith<O> {
  final ActionInternal _value;
  final O Function(ActionInternal) _then;
  _$ActionInternalCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? processed = dimmutable,
      Object? type = dimmutable,
      Object? data = dimmutable}) {
    return _then(_value.copyWith(
        processed:
            processed == dimmutable ? _value.processed : processed as bool,
        type: type == dimmutable ? _value.type : type as ActionInternalType,
        data: data == dimmutable ? _value.data : data as dynamic));
  }
}

abstract class _$ActionInternalCopyWith<O>
    implements $ActionInternalCopyWith<O> {
  factory _$ActionInternalCopyWith(
          ActionInternal value, O Function(ActionInternal) then) =
      __$ActionInternalCopyWithImpl<O>;
  O call({bool processed, ActionInternalType type, dynamic data});
}

class __$ActionInternalCopyWithImpl<O> extends _$ActionInternalCopyWithImpl<O>
    implements _$ActionInternalCopyWith<O> {
  __$ActionInternalCopyWithImpl(
      ActionInternal _value, O Function(ActionInternal) _then)
      : super(_value, (v) => _then(v));

  @override
  ActionInternal get _value => super._value;

  @override
  O call(
      {Object? processed = dimmutable,
      Object? type = dimmutable,
      Object? data = dimmutable}) {
    return _then(ActionInternal(
        processed:
            processed == dimmutable ? _value.processed : processed as bool,
        type: type == dimmutable ? _value.type : type as ActionInternalType,
        data: data == dimmutable ? _value.data : data as dynamic));
  }
}
