// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_state.dart';

// **************************************************************************
// PStateGenerator
// **************************************************************************

@immutable
class FormState extends PStateModel<FormState> {
  final String name;

  _$FormStateCopyWith<FormState> get copyWith =>
      __$FormStateCopyWithImpl<FormState>(this, IdentityFn);

  FormState({this.name = "in"});

  @override
  FormState copyWithMap(Map<String, dynamic> map) => FormState(
      name: map.containsKey("name") ? map["name"] as String : this.name);

  Map<String, dynamic> toMap() => <String, dynamic>{"name": this.name};

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is FormState && o.name == name;
  }

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => "FormState(name: ${this.name})";
}

abstract class $FormStateCopyWith<O> {
  factory $FormStateCopyWith(FormState value, O Function(FormState) then) =
      _$FormStateCopyWithImpl<O>;
  O call({String name});
}

class _$FormStateCopyWithImpl<O> implements $FormStateCopyWith<O> {
  final FormState _value;
  final O Function(FormState) _then;
  _$FormStateCopyWithImpl(this._value, this._then);

  @override
  O call({Object? name = dimmutable}) {
    return _then(_value.copyWith(
        name: name == dimmutable ? _value.name : name as String));
  }
}

abstract class _$FormStateCopyWith<O> implements $FormStateCopyWith<O> {
  factory _$FormStateCopyWith(FormState value, O Function(FormState) then) =
      __$FormStateCopyWithImpl<O>;
  O call({String name});
}

class __$FormStateCopyWithImpl<O> extends _$FormStateCopyWithImpl<O>
    implements _$FormStateCopyWith<O> {
  __$FormStateCopyWithImpl(FormState _value, O Function(FormState) _then)
      : super(_value, (v) => _then(v));

  @override
  FormState get _value => super._value;

  @override
  O call({Object? name = dimmutable}) {
    return _then(
        FormState(name: name == dimmutable ? _value.name : name as String));
  }
}

const _FormState_FullPath = "/store/pstates/form_state/FormState";

abstract class FormStateActions {}

FormState FormState_DS() => FormState(name: "in");

final FormStateMeta =
    PStateMeta<FormState>(type: _FormState_FullPath, ds: FormState_DS);
