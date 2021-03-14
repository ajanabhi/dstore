// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'action.dart';

// **************************************************************************
// DImmutableGenerator
// **************************************************************************

mixin _$Action {
  String get name;
  String get type;
  bool get isAsync;
  Map<String, dynamic>? get payload;
  HttpPayload<dynamic, dynamic, dynamic, dynamic>? get http;
  WebSocketPayload<dynamic, dynamic, dynamic>? get ws;
  dynamic get extra;
  ActionInternal? get internal;
  Stream<dynamic>? get stream;
  Duration? get debounce;
  FormReq? get form;

  $ActionCopyWith<Action> get copyWith;
}

class _Action implements Action {
  @override
  final String name;

  @override
  final String type;

  @override
  @Default(false)
  @JsonKey(defaultValue: false)
  final bool isAsync;

  @override
  final Map<String, dynamic>? payload;

  @override
  final HttpPayload<dynamic, dynamic, dynamic, dynamic>? http;

  @override
  final WebSocketPayload<dynamic, dynamic, dynamic>? ws;

  @override
  @Default(null)
  @JsonKey(defaultValue: null)
  final dynamic extra;

  @override
  final ActionInternal? internal;

  @override
  final Stream<dynamic>? stream;

  @override
  final Duration? debounce;

  @override
  final FormReq? form;

  _$ActionCopyWith<Action> get copyWith =>
      __$ActionCopyWithImpl<Action>(this, IdentityFn);

  const _Action(
      {required this.name,
      required this.type,
      this.isAsync = false,
      this.payload,
      this.http,
      this.ws,
      this.extra = null,
      this.internal,
      this.stream,
      this.debounce,
      this.form});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is _Action &&
        o.name == name &&
        o.type == type &&
        o.isAsync == isAsync &&
        o.payload == payload &&
        o.http == http &&
        o.ws == ws &&
        o.extra == extra &&
        o.internal == internal &&
        o.stream == stream &&
        o.debounce == debounce &&
        o.form == form;
  }

  @override
  int get hashCode =>
      name.hashCode ^
      type.hashCode ^
      isAsync.hashCode ^
      payload.hashCode ^
      http.hashCode ^
      ws.hashCode ^
      extra.hashCode ^
      internal.hashCode ^
      stream.hashCode ^
      debounce.hashCode ^
      form.hashCode;

  @override
  String toString() =>
      "Action(name: ${this.name}, type: ${this.type}, isAsync: ${this.isAsync}, payload: ${this.payload}, http: ${this.http}, ws: ${this.ws}, extra: ${this.extra}, internal: ${this.internal}, stream: ${this.stream}, debounce: ${this.debounce}, form: ${this.form})";
}

abstract class $ActionCopyWith<O> {
  factory $ActionCopyWith(Action value, O Function(Action) then) =
      _$ActionCopyWithImpl<O>;
  O call(
      {String name,
      String type,
      bool isAsync,
      Map<String, dynamic>? payload,
      HttpPayload<dynamic, dynamic, dynamic, dynamic>? http,
      WebSocketPayload<dynamic, dynamic, dynamic>? ws,
      dynamic extra,
      ActionInternal? internal,
      Stream<dynamic>? stream,
      Duration? debounce,
      FormReq? form});
}

class _$ActionCopyWithImpl<O> implements $ActionCopyWith<O> {
  final Action _value;
  final O Function(Action) _then;
  _$ActionCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? name = dimmutable,
      Object? type = dimmutable,
      Object? isAsync = dimmutable,
      Object? payload = dimmutable,
      Object? http = dimmutable,
      Object? ws = dimmutable,
      Object? extra = dimmutable,
      Object? internal = dimmutable,
      Object? stream = dimmutable,
      Object? debounce = dimmutable,
      Object? form = dimmutable}) {
    return _then(_value.copyWith(
        name: name == dimmutable ? _value.name : name as String,
        type: type == dimmutable ? _value.type : type as String,
        isAsync: isAsync == dimmutable ? _value.isAsync : isAsync as bool,
        payload: payload == dimmutable
            ? _value.payload
            : payload as Map<String, dynamic>?,
        http: http == dimmutable
            ? _value.http
            : http as HttpPayload<dynamic, dynamic, dynamic, dynamic>?,
        ws: ws == dimmutable
            ? _value.ws
            : ws as WebSocketPayload<dynamic, dynamic, dynamic>?,
        extra: extra == dimmutable ? _value.extra : extra as dynamic,
        internal: internal == dimmutable
            ? _value.internal
            : internal as ActionInternal?,
        stream:
            stream == dimmutable ? _value.stream : stream as Stream<dynamic>?,
        debounce:
            debounce == dimmutable ? _value.debounce : debounce as Duration?,
        form: form == dimmutable ? _value.form : form as FormReq?));
  }
}

abstract class _$ActionCopyWith<O> implements $ActionCopyWith<O> {
  factory _$ActionCopyWith(Action value, O Function(Action) then) =
      __$ActionCopyWithImpl<O>;
  O call(
      {String name,
      String type,
      bool isAsync,
      Map<String, dynamic>? payload,
      HttpPayload<dynamic, dynamic, dynamic, dynamic>? http,
      WebSocketPayload<dynamic, dynamic, dynamic>? ws,
      dynamic extra,
      ActionInternal? internal,
      Stream<dynamic>? stream,
      Duration? debounce,
      FormReq? form});
}

class __$ActionCopyWithImpl<O> extends _$ActionCopyWithImpl<O>
    implements _$ActionCopyWith<O> {
  __$ActionCopyWithImpl(Action _value, O Function(Action) _then)
      : super(_value, (v) => _then(v));

  @override
  Action get _value => super._value;

  @override
  O call(
      {Object? name = dimmutable,
      Object? type = dimmutable,
      Object? isAsync = dimmutable,
      Object? payload = dimmutable,
      Object? http = dimmutable,
      Object? ws = dimmutable,
      Object? extra = dimmutable,
      Object? internal = dimmutable,
      Object? stream = dimmutable,
      Object? debounce = dimmutable,
      Object? form = dimmutable}) {
    return _then(Action(
        name: name == dimmutable ? _value.name : name as String,
        type: type == dimmutable ? _value.type : type as String,
        isAsync: isAsync == dimmutable ? _value.isAsync : isAsync as bool,
        payload: payload == dimmutable
            ? _value.payload
            : payload as Map<String, dynamic>?,
        http: http == dimmutable
            ? _value.http
            : http as HttpPayload<dynamic, dynamic, dynamic, dynamic>?,
        ws: ws == dimmutable
            ? _value.ws
            : ws as WebSocketPayload<dynamic, dynamic, dynamic>?,
        extra: extra == dimmutable ? _value.extra : extra as dynamic,
        internal: internal == dimmutable
            ? _value.internal
            : internal as ActionInternal?,
        stream:
            stream == dimmutable ? _value.stream : stream as Stream<dynamic>?,
        debounce:
            debounce == dimmutable ? _value.debounce : debounce as Duration?,
        form: form == dimmutable ? _value.form : form as FormReq?));
  }
}

mixin _$ActionInternal {
  bool get processed;
  ActionInternalType get type;
  dynamic get data;

  $ActionInternalCopyWith<ActionInternal> get copyWith;
}

class _ActionInternal implements ActionInternal {
  @override
  final bool processed;

  @override
  final ActionInternalType type;

  @override
  final dynamic data;

  _$ActionInternalCopyWith<ActionInternal> get copyWith =>
      __$ActionInternalCopyWithImpl<ActionInternal>(this, IdentityFn);

  const _ActionInternal(
      {required this.processed, required this.type, required this.data});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is _ActionInternal &&
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
