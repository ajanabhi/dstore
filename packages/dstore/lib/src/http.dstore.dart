// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'http.dart';

// **************************************************************************
// DImmutableGenerator
// **************************************************************************

mixin _$Hello {
  String get name;

  $HelloCopyWith<Hello> get copyWith;
}

class _Hello implements Hello {
  @override
  final String name;

  _$HelloCopyWith<Hello> get copyWith =>
      __$HelloCopyWithImpl<Hello>(this, IdentityFn);

  const _Hello({required this.name});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is _Hello && o.name == name;
  }

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => "Hello(name: ${this.name})";
}

abstract class $HelloCopyWith<O> {
  factory $HelloCopyWith(Hello value, O Function(Hello) then) =
      _$HelloCopyWithImpl<O>;
  O call({String name});
}

class _$HelloCopyWithImpl<O> implements $HelloCopyWith<O> {
  final Hello _value;
  final O Function(Hello) _then;
  _$HelloCopyWithImpl(this._value, this._then);

  @override
  O call({Object? name = dimmutable}) {
    return _then(_value.copyWith(
        name: name == dimmutable ? _value.name : name as String));
  }
}

abstract class _$HelloCopyWith<O> implements $HelloCopyWith<O> {
  factory _$HelloCopyWith(Hello value, O Function(Hello) then) =
      __$HelloCopyWithImpl<O>;
  O call({String name});
}

class __$HelloCopyWithImpl<O> extends _$HelloCopyWithImpl<O>
    implements _$HelloCopyWith<O> {
  __$HelloCopyWithImpl(Hello _value, O Function(Hello) _then)
      : super(_value, (v) => _then(v));

  @override
  Hello get _value => super._value;

  @override
  O call({Object? name = dimmutable}) {
    return _then(
        Hello(name: name == dimmutable ? _value.name : name as String));
  }
}

mixin _$HttpField<QP, I, R, E> {
  bool get loading;
  R? get data;
  HttpError<E>? get error;
  bool get completed;
  bool get optimistic;
  AbortController? get abortController;

  $HttpFieldCopyWith<QP, I, R, E, HttpField<QP, I, R, E>> get copyWith;
}

class _HttpField<QP, I, R, E> implements HttpField<QP, I, R, E> {
  @override
  @Default(false)
  @JsonKey(defaultValue: false)
  final bool loading;

  @override
  final R? data;

  @override
  final HttpError<E>? error;

  @override
  @Default(false)
  @JsonKey(defaultValue: false)
  final bool completed;

  @override
  @Default(false)
  @JsonKey(defaultValue: false)
  final bool optimistic;

  @override
  final AbortController? abortController;

  _$HttpFieldCopyWith<QP, I, R, E, HttpField<QP, I, R, E>> get copyWith =>
      __$HttpFieldCopyWithImpl<QP, I, R, E, HttpField<QP, I, R, E>>(
          this, IdentityFn);

  const _HttpField(
      {this.loading = false,
      this.data,
      this.error,
      this.completed = false,
      this.optimistic = false,
      this.abortController});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is _HttpField &&
        o.loading == loading &&
        o.data == data &&
        o.error == error &&
        o.completed == completed &&
        o.optimistic == optimistic &&
        o.abortController == abortController;
  }

  @override
  int get hashCode =>
      loading.hashCode ^
      data.hashCode ^
      error.hashCode ^
      completed.hashCode ^
      optimistic.hashCode ^
      abortController.hashCode;

  @override
  String toString() =>
      "HttpField(loading: ${this.loading}, data: ${this.data}, error: ${this.error}, completed: ${this.completed}, optimistic: ${this.optimistic}, abortController: ${this.abortController})";
}

abstract class $HttpFieldCopyWith<QP, I, R, E, O> {
  factory $HttpFieldCopyWith(HttpField<QP, I, R, E> value,
          O Function(HttpField<QP, I, R, E>) then) =
      _$HttpFieldCopyWithImpl<QP, I, R, E, O>;
  O call(
      {bool loading,
      R? data,
      HttpError<E>? error,
      bool completed,
      bool optimistic,
      AbortController? abortController});
}

class _$HttpFieldCopyWithImpl<QP, I, R, E, O>
    implements $HttpFieldCopyWith<QP, I, R, E, O> {
  final HttpField<QP, I, R, E> _value;
  final O Function(HttpField<QP, I, R, E>) _then;
  _$HttpFieldCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? loading = dimmutable,
      Object? data = dimmutable,
      Object? error = dimmutable,
      Object? completed = dimmutable,
      Object? optimistic = dimmutable,
      Object? abortController = dimmutable}) {
    return _then(_value.copyWith(
        loading: loading == dimmutable ? _value.loading : loading as bool,
        data: data == dimmutable ? _value.data : data as R?,
        error: error == dimmutable ? _value.error : error as HttpError<E>?,
        completed:
            completed == dimmutable ? _value.completed : completed as bool,
        optimistic:
            optimistic == dimmutable ? _value.optimistic : optimistic as bool,
        abortController: abortController == dimmutable
            ? _value.abortController
            : abortController as AbortController?));
  }
}

abstract class _$HttpFieldCopyWith<QP, I, R, E, O>
    implements $HttpFieldCopyWith<QP, I, R, E, O> {
  factory _$HttpFieldCopyWith(HttpField<QP, I, R, E> value,
          O Function(HttpField<QP, I, R, E>) then) =
      __$HttpFieldCopyWithImpl<QP, I, R, E, O>;
  O call(
      {bool loading,
      R? data,
      HttpError<E>? error,
      bool completed,
      bool optimistic,
      AbortController? abortController});
}

class __$HttpFieldCopyWithImpl<QP, I, R, E, O>
    extends _$HttpFieldCopyWithImpl<QP, I, R, E, O>
    implements _$HttpFieldCopyWith<QP, I, R, E, O> {
  __$HttpFieldCopyWithImpl(
      HttpField<QP, I, R, E> _value, O Function(HttpField<QP, I, R, E>) _then)
      : super(_value, (v) => _then(v));

  @override
  HttpField<QP, I, R, E> get _value => super._value;

  @override
  O call(
      {Object? loading = dimmutable,
      Object? data = dimmutable,
      Object? error = dimmutable,
      Object? completed = dimmutable,
      Object? optimistic = dimmutable,
      Object? abortController = dimmutable}) {
    return _then(HttpField(
        loading: loading == dimmutable ? _value.loading : loading as bool,
        data: data == dimmutable ? _value.data : data as R?,
        error: error == dimmutable ? _value.error : error as HttpError<E>?,
        completed:
            completed == dimmutable ? _value.completed : completed as bool,
        optimistic:
            optimistic == dimmutable ? _value.optimistic : optimistic as bool,
        abortController: abortController == dimmutable
            ? _value.abortController
            : abortController as AbortController?));
  }
}
