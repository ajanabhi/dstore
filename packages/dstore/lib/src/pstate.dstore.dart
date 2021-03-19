// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'pstate.dart';

// **************************************************************************
// DImmutableGenerator
// **************************************************************************

mixin _$AsyncActionField {
  bool get loading;
  bool get completed;
  dynamic get error;

  @JsonKey(ignore: true)
  $AsyncActionFieldCopyWith<AsyncActionField> get copyWith;
  Map<String, dynamic> toJson();
}

@JsonSerializable()
class _AsyncActionField implements AsyncActionField {
  @override
  @Default(false)
  @JsonKey(defaultValue: false)
  final bool loading;

  @override
  @Default(false)
  @JsonKey(defaultValue: false)
  final bool completed;

  @override
  @Default(null)
  @JsonKey(defaultValue: null)
  final dynamic error;

  @JsonKey(ignore: true)
  _$AsyncActionFieldCopyWith<AsyncActionField> get copyWith =>
      __$AsyncActionFieldCopyWithImpl<AsyncActionField>(this, IdentityFn);

  const _AsyncActionField(
      {this.loading = false, this.completed = false, this.error = null});

  factory _AsyncActionField.fromJson(Map<String, dynamic> json) =>
      _$_AsyncActionFieldFromJson(json);

  Map<String, dynamic> toJson() => _$_AsyncActionFieldToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is _AsyncActionField &&
        o.loading == loading &&
        o.completed == completed &&
        o.error == error;
  }

  @override
  int get hashCode => loading.hashCode ^ completed.hashCode ^ error.hashCode;

  @override
  String toString() =>
      "AsyncActionField(loading: ${this.loading}, completed: ${this.completed}, error: ${this.error})";
}

AsyncActionField _$AsyncActionFieldFromJson(Map<String, dynamic> json) =>
    _AsyncActionField.fromJson(json);

abstract class $AsyncActionFieldCopyWith<O> {
  factory $AsyncActionFieldCopyWith(
          AsyncActionField value, O Function(AsyncActionField) then) =
      _$AsyncActionFieldCopyWithImpl<O>;
  O call({bool loading, bool completed, dynamic error});
}

class _$AsyncActionFieldCopyWithImpl<O>
    implements $AsyncActionFieldCopyWith<O> {
  final AsyncActionField _value;
  final O Function(AsyncActionField) _then;
  _$AsyncActionFieldCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? loading = dimmutable,
      Object? completed = dimmutable,
      Object? error = dimmutable}) {
    return _then(_value.copyWith(
        loading: loading == dimmutable ? _value.loading : loading as bool,
        completed:
            completed == dimmutable ? _value.completed : completed as bool,
        error: error == dimmutable ? _value.error : error as dynamic));
  }
}

abstract class _$AsyncActionFieldCopyWith<O>
    implements $AsyncActionFieldCopyWith<O> {
  factory _$AsyncActionFieldCopyWith(
          AsyncActionField value, O Function(AsyncActionField) then) =
      __$AsyncActionFieldCopyWithImpl<O>;
  O call({bool loading, bool completed, dynamic error});
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
  O call(
      {Object? loading = dimmutable,
      Object? completed = dimmutable,
      Object? error = dimmutable}) {
    return _then(AsyncActionField(
        loading: loading == dimmutable ? _value.loading : loading as bool,
        completed:
            completed == dimmutable ? _value.completed : completed as bool,
        error: error == dimmutable ? _value.error : error as dynamic));
  }
}
