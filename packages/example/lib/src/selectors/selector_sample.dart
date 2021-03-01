import 'package:dstore/dstore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:dstore_example/src/pstates/sample.dart';
import 'package:dstore_example/src/sample_state.dart';
import 'package:dstore_example/src/selectors/types2.dart';

part 'selector_sample.dstore.dart';
part 'selector_sample.g.dart';

// class Hello {
//   String bollo = "";
// }

// class AppState {
//   User? sample;
//   Hello hello = Hello();
// }

@Selectors()
// ignore: unused_element
class _AppSelectors {
  static S1 hello(AppState state) {
    final n = state.sample.name.name;
    // final c = state.sample;
    print("hello2");
    final s = state.sample.s;
    final sf = state.sample.sf;
    final wf = state.sample.wm;
    // final s1 = state.sample;
    final s2 = state.sample.fint;

    return S1(name: n, s: s);
    // return state.sample.name.name;
  }
}

abstract class $MCopyWith<O> {
  factory $MCopyWith(M value, O Function(M) then) = _$MCopyWithImpl<O>;

  O call({required String name, int age});
}

class _$MCopyWithImpl<O> implements $MCopyWith<O> {
  final M _value;
  final O Function(M) _then;

  _$MCopyWithImpl(this._value, this._then);

  @override
  O call({Object? name = dimmutable, Object? age = dimmutable}) {
    return _then(_value.copyWith(
        name: name == dimmutable ? _value.name : name as String,
        age: age == dimmutable ? _value.age : age as int?));
  }
}

/// @nodoc
abstract class _$MCopyWith<$Res> implements $MCopyWith<$Res> {
  factory _$MCopyWith(M value, $Res Function(M) then) = __$MCopyWithImpl<$Res>;
  @override
  $Res call({String name, int? age});
}

/// @nodoc
class __$MCopyWithImpl<$Res> extends _$MCopyWithImpl<$Res>
    implements _$MCopyWith<$Res> {
  __$MCopyWithImpl(M _value, $Res Function(M) _then)
      : super(_value, (v) => _then(v));

  @override
  M get _value => super._value as M;

  @override
  $Res call({
    Object? name = freezed,
    Object? age = freezed,
  }) {
    return _then(M(
      name: name == freezed ? _value.name : name as String,
      age: age == freezed ? _value.age : age as int?,
    ));
  }
}

M idf<T>(M v) => v;
T idf2<T>(T v) => v;

class M {
  final String name;
  final int? age;

  M({required this.name, this.age});

  _$MCopyWith<M> get copyWith => __$MCopyWithImpl<M>(this, idf2);

  @override
  String toString() => 'M(name: $name, age: $age)';
}

@DImmutable()
abstract class S1 with _$S1 {
  const factory S1({required String name, required int s, String? op3}) = _S1;
}
