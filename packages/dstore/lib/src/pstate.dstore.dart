// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'pstate.dart';

// **************************************************************************
// DImmutableGenerator
// **************************************************************************

mixin _$AsyncActionField {
  bool get loading;
  dynamic get error;

  $AsyncActionFieldCopyWith<AsyncActionField> get copyWith;
}

class _AsyncActionField implements AsyncActionField {
  @override
  @Default(false)
  @JsonKey(defaultValue: false)
  final bool loading;

  @override
  @Default(null)
  @JsonKey(defaultValue: null)
  final dynamic error;

  _$AsyncActionFieldCopyWith<AsyncActionField> get copyWith =>
      __$AsyncActionFieldCopyWithImpl<AsyncActionField>(this, IdentityFn);

  const _AsyncActionField({this.loading = false, this.error = null});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is _AsyncActionField && o.loading == loading && o.error == error;
  }

  @override
  int get hashCode => loading.hashCode ^ error.hashCode;

  @override
  String toString() =>
      "AsyncActionField(loading: ${this.loading}, error: ${this.error})";
}

abstract class $AsyncActionFieldCopyWith<O> {
  factory $AsyncActionFieldCopyWith(
          AsyncActionField value, O Function(AsyncActionField) then) =
      _$AsyncActionFieldCopyWithImpl<O>;
  O call({bool loading, dynamic error});
}

class _$AsyncActionFieldCopyWithImpl<O>
    implements $AsyncActionFieldCopyWith<O> {
  final AsyncActionField _value;
  final O Function(AsyncActionField) _then;
  _$AsyncActionFieldCopyWithImpl(this._value, this._then);

  @override
  O call({Object? loading = dimmutable, Object? error = dimmutable}) {
    return _then(_value.copyWith(
        loading: loading == dimmutable ? _value.loading : loading as bool,
        error: error == dimmutable ? _value.error : error as dynamic));
  }
}

abstract class _$AsyncActionFieldCopyWith<O>
    implements $AsyncActionFieldCopyWith<O> {
  factory _$AsyncActionFieldCopyWith(
          AsyncActionField value, O Function(AsyncActionField) then) =
      __$AsyncActionFieldCopyWithImpl<O>;
  O call({bool loading, dynamic error});
}

class __$AsyncActionFieldCopyWithImpl<O>
    extends _$AsyncActionFieldCopyWithImpl<O>
    implements _$AsyncActionFieldCopyWith<O> {
  __$AsyncActionFieldCopyWithImpl(
      AsyncActionField _value, O Function(AsyncActionField) _then)
      : super(_value, (v) => _then(v));

  @override
  AsyncActionField get _value => super._value;

  @override
  O call({Object? loading = dimmutable, Object? error = dimmutable}) {
    return _then(AsyncActionField(
        loading: loading == dimmutable ? _value.loading : loading as bool,
        error: error == dimmutable ? _value.error : error as dynamic));
  }
}

mixin _$StreamField<D> {
  D? get d;
  StreamSubscription<dynamic>? get internalSubscription;
  dynamic get error;
  bool get listening;
  bool get completed;

  $StreamFieldCopyWith<D, StreamField<D>> get copyWith;
}

class _StreamField<D> implements StreamField<D> {
  @override
  final D? d;

  @override
  final StreamSubscription<dynamic>? internalSubscription;

  @override
  @Default(null)
  @JsonKey(defaultValue: null)
  final dynamic error;

  @override
  @Default(false)
  @JsonKey(defaultValue: false)
  final bool listening;

  @override
  @Default(false)
  @JsonKey(defaultValue: false)
  final bool completed;

  _$StreamFieldCopyWith<D, StreamField<D>> get copyWith =>
      __$StreamFieldCopyWithImpl<D, StreamField<D>>(this, IdentityFn);

  const _StreamField(
      {this.d,
      this.internalSubscription,
      this.error = null,
      this.listening = false,
      this.completed = false});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is _StreamField &&
        o.d == d &&
        o.internalSubscription == internalSubscription &&
        o.error == error &&
        o.listening == listening &&
        o.completed == completed;
  }

  @override
  int get hashCode =>
      d.hashCode ^
      internalSubscription.hashCode ^
      error.hashCode ^
      listening.hashCode ^
      completed.hashCode;

  @override
  String toString() =>
      "StreamField(d: ${this.d}, internalSubscription: ${this.internalSubscription}, error: ${this.error}, listening: ${this.listening}, completed: ${this.completed})";
}

abstract class $StreamFieldCopyWith<D, O> {
  factory $StreamFieldCopyWith(
          StreamField<D> value, O Function(StreamField<D>) then) =
      _$StreamFieldCopyWithImpl<D, O>;
  O call(
      {D? d,
      StreamSubscription<dynamic>? internalSubscription,
      dynamic error,
      bool listening,
      bool completed});
}

class _$StreamFieldCopyWithImpl<D, O> implements $StreamFieldCopyWith<D, O> {
  final StreamField<D> _value;
  final O Function(StreamField<D>) _then;
  _$StreamFieldCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? d = dimmutable,
      Object? internalSubscription = dimmutable,
      Object? error = dimmutable,
      Object? listening = dimmutable,
      Object? completed = dimmutable}) {
    return _then(_value.copyWith(
        d: d == dimmutable ? _value.d : d as D?,
        internalSubscription: internalSubscription == dimmutable
            ? _value.internalSubscription
            : internalSubscription as StreamSubscription<dynamic>?,
        error: error == dimmutable ? _value.error : error as dynamic,
        listening:
            listening == dimmutable ? _value.listening : listening as bool,
        completed:
            completed == dimmutable ? _value.completed : completed as bool));
  }
}

abstract class _$StreamFieldCopyWith<D, O>
    implements $StreamFieldCopyWith<D, O> {
  factory _$StreamFieldCopyWith(
          StreamField<D> value, O Function(StreamField<D>) then) =
      __$StreamFieldCopyWithImpl<D, O>;
  O call(
      {D? d,
      StreamSubscription<dynamic>? internalSubscription,
      dynamic error,
      bool listening,
      bool completed});
}

class __$StreamFieldCopyWithImpl<D, O> extends _$StreamFieldCopyWithImpl<D, O>
    implements _$StreamFieldCopyWith<D, O> {
  __$StreamFieldCopyWithImpl(
      StreamField<D> _value, O Function(StreamField<D>) _then)
      : super(_value, (v) => _then(v));

  @override
  StreamField<D> get _value => super._value;

  @override
  O call(
      {Object? d = dimmutable,
      Object? internalSubscription = dimmutable,
      Object? error = dimmutable,
      Object? listening = dimmutable,
      Object? completed = dimmutable}) {
    return _then(StreamField(
        d: d == dimmutable ? _value.d : d as D?,
        internalSubscription: internalSubscription == dimmutable
            ? _value.internalSubscription
            : internalSubscription as StreamSubscription<dynamic>?,
        error: error == dimmutable ? _value.error : error as dynamic,
        listening:
            listening == dimmutable ? _value.listening : listening as bool,
        completed:
            completed == dimmutable ? _value.completed : completed as bool));
  }
}
