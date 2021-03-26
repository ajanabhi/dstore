// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample2.dart';

// **************************************************************************
// PStateGenerator
// **************************************************************************

@immutable
class Sample2 extends PStateModel<Sample2> {
  final String name;

  _$Sample2CopyWith<Sample2> get copyWith =>
      __$Sample2CopyWithImpl<Sample2>(this, IdentityFn);

  Sample2({this.name = "name2"});

  @override
  Sample2 copyWithMap(Map<String, dynamic> map) => Sample2(
      name: map.containsKey("name") ? map["name"] as String : this.name);

  Map<String, dynamic> toMap() => <String, dynamic>{"name": this.name};

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is Sample2 && o.name == name;
  }

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => "Sample2(name: ${this.name})";
}

abstract class $Sample2CopyWith<O> {
  factory $Sample2CopyWith(Sample2 value, O Function(Sample2) then) =
      _$Sample2CopyWithImpl<O>;
  O call({String name});
}

class _$Sample2CopyWithImpl<O> implements $Sample2CopyWith<O> {
  final Sample2 _value;
  final O Function(Sample2) _then;
  _$Sample2CopyWithImpl(this._value, this._then);

  @override
  O call({Object? name = dimmutable}) {
    return _then(_value.copyWith(
        name: name == dimmutable ? _value.name : name as String));
  }
}

abstract class _$Sample2CopyWith<O> implements $Sample2CopyWith<O> {
  factory _$Sample2CopyWith(Sample2 value, O Function(Sample2) then) =
      __$Sample2CopyWithImpl<O>;
  O call({String name});
}

class __$Sample2CopyWithImpl<O> extends _$Sample2CopyWithImpl<O>
    implements _$Sample2CopyWith<O> {
  __$Sample2CopyWithImpl(Sample2 _value, O Function(Sample2) _then)
      : super(_value, (v) => _then(v));

  @override
  Sample2 get _value => super._value;

  @override
  O call({Object? name = dimmutable}) {
    return _then(
        Sample2(name: name == dimmutable ? _value.name : name as String));
  }
}

const _Sample2_FullPath = "/dstore/test/store/pstates/sample2/sample2/Sample2";

abstract class Sample2Actions {}

Sample2 Sample2_DS() => Sample2(name: "name2");

final Sample2Meta =
    PStateMeta<Sample2>(type: _Sample2_FullPath, ds: Sample2_DS);
