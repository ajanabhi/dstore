// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'selector_sample.dart';

// **************************************************************************
// SelectorsGenerator
// **************************************************************************

// Selector
class AppSelectors {
  static final hello = Selector<AppState, S1>(fn: _AppSelectors.hello, deps: {
    "sample": ["name", "s"]
  });
}

// **************************************************************************
// DImmutableGenerator
// **************************************************************************

mixin _$S1 {
  String get name;
  int get s;

  S1 copyWith({String? name, int? s});
}

class _S1 implements S1 {
  @override
  final String name;

  @override
  final int s;

  const _S1({required this.name, required this.s});

  @override
  _S1 copyWith({String? name, int? s}) =>
      _S1(name: name ?? this.name, s: s ?? this.s);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is _S1 && o.name == name && o.s == s;
  }

  @override
  int get hashCode => name.hashCode ^ s.hashCode;

  @override
  String toString() => "S1(name: ${this.name}, s: ${this.s})";
}
