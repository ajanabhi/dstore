// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'action.dart';

// **************************************************************************
// DImmutableGenerator
// **************************************************************************

mixin _$Action<M> {
  String get name;
  String get type;
  bool get isAsync;
  Map<String, dynamic>? get payload;
  HttpPayload<dynamic, dynamic, dynamic, dynamic>? get http;
  WebSocketPayload<dynamic, dynamic, dynamic>? get ws;
  dynamic get extra;
  ActionInternal? get internal;
  StreamPayload? get stream;
  Duration? get debounce;
  M? get mock;
  dynamic get fieldMock;
  FormReq? get form;

  $ActionCopyWith<M, Action<M>> get copyWith;
}

class _Action<M> implements Action<M> {
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
  final StreamPayload? stream;

  @override
  final Duration? debounce;

  @override
  final M? mock;

  @override
  @Default(null)
  @JsonKey(defaultValue: null)
  final dynamic fieldMock;

  @override
  final FormReq? form;

  _$ActionCopyWith<M, Action<M>> get copyWith =>
      __$ActionCopyWithImpl<M, Action<M>>(this, IdentityFn);

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
      this.mock,
      this.fieldMock = null,
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
        o.mock == mock &&
        o.fieldMock == fieldMock &&
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
      mock.hashCode ^
      fieldMock.hashCode ^
      form.hashCode;

  @override
  String toString() =>
      "Action(name: ${this.name}, type: ${this.type}, isAsync: ${this.isAsync}, payload: ${this.payload}, http: ${this.http}, ws: ${this.ws}, extra: ${this.extra}, internal: ${this.internal}, stream: ${this.stream}, debounce: ${this.debounce}, mock: ${this.mock}, fieldMock: ${this.fieldMock}, form: ${this.form})";
}

abstract class $ActionCopyWith<M, O> {
  factory $ActionCopyWith(Action<M> value, O Function(Action<M>) then) =
      _$ActionCopyWithImpl<M, O>;
  O call(
      {String name,
      String type,
      bool isAsync,
      Map<String, dynamic>? payload,
      HttpPayload<dynamic, dynamic, dynamic, dynamic>? http,
      WebSocketPayload<dynamic, dynamic, dynamic>? ws,
      dynamic extra,
      ActionInternal? internal,
      StreamPayload? stream,
      Duration? debounce,
      M? mock,
      dynamic fieldMock,
      FormReq? form});
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
      Object? payload = dimmutable,
      Object? http = dimmutable,
      Object? ws = dimmutable,
      Object? extra = dimmutable,
      Object? internal = dimmutable,
      Object? stream = dimmutable,
      Object? debounce = dimmutable,
      Object? mock = dimmutable,
      Object? fieldMock = dimmutable,
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
        stream: stream == dimmutable ? _value.stream : stream as StreamPayload?,
        debounce:
            debounce == dimmutable ? _value.debounce : debounce as Duration?,
        mock: mock == dimmutable ? _value.mock : mock as M?,
        fieldMock:
            fieldMock == dimmutable ? _value.fieldMock : fieldMock as dynamic,
        form: form == dimmutable ? _value.form : form as FormReq?));
  }
}

abstract class _$ActionCopyWith<M, O> implements $ActionCopyWith<M, O> {
  factory _$ActionCopyWith(Action<M> value, O Function(Action<M>) then) =
      __$ActionCopyWithImpl<M, O>;
  O call(
      {String name,
      String type,
      bool isAsync,
      Map<String, dynamic>? payload,
      HttpPayload<dynamic, dynamic, dynamic, dynamic>? http,
      WebSocketPayload<dynamic, dynamic, dynamic>? ws,
      dynamic extra,
      ActionInternal? internal,
      StreamPayload? stream,
      Duration? debounce,
      M? mock,
      dynamic fieldMock,
      FormReq? form});
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
      Object? payload = dimmutable,
      Object? http = dimmutable,
      Object? ws = dimmutable,
      Object? extra = dimmutable,
      Object? internal = dimmutable,
      Object? stream = dimmutable,
      Object? debounce = dimmutable,
      Object? mock = dimmutable,
      Object? fieldMock = dimmutable,
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
        stream: stream == dimmutable ? _value.stream : stream as StreamPayload?,
        debounce:
            debounce == dimmutable ? _value.debounce : debounce as Duration?,
        mock: mock == dimmutable ? _value.mock : mock as M?,
        fieldMock:
            fieldMock == dimmutable ? _value.fieldMock : fieldMock as dynamic,
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
