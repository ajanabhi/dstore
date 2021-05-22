import 'package:dstore/dstore.dart';

// part "nav.dstore.dart";

// @dimmutable
// void $_NavPayload(String? rawUrl, String? nestedNavTypeName,
//     {bool processedNested = false}) {}

class NavPayload {
  final String? rawUrl;

  final String? nestedNavTypeName;

  final bool processedNested;

  _$NavPayloadCopyWith<NavPayload> get copyWith =>
      __$NavPayloadCopyWithImpl<NavPayload>(this, IdentityFn);

  const NavPayload(
      {this.rawUrl, this.nestedNavTypeName, this.processedNested = false});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is NavPayload &&
        o.rawUrl == rawUrl &&
        o.nestedNavTypeName == nestedNavTypeName &&
        o.processedNested == processedNested;
  }

  @override
  int get hashCode =>
      rawUrl.hashCode ^ nestedNavTypeName.hashCode ^ processedNested.hashCode;

  @override
  String toString() =>
      "NavPayload(rawUrl: ${this.rawUrl}, nestedNavTypeName: ${this.nestedNavTypeName}, processedNested: ${this.processedNested})";
}

abstract class $NavPayloadCopyWith<O> {
  factory $NavPayloadCopyWith(NavPayload value, O Function(NavPayload) then) =
      _$NavPayloadCopyWithImpl<O>;
  O call({String? rawUrl, String? nestedNavTypeName, bool processedNested});
}

class _$NavPayloadCopyWithImpl<O> implements $NavPayloadCopyWith<O> {
  final NavPayload _value;
  final O Function(NavPayload) _then;
  _$NavPayloadCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? rawUrl = dimmutable,
      Object? nestedNavTypeName = dimmutable,
      Object? processedNested = dimmutable}) {
    return _then(_value.copyWith(
        rawUrl: rawUrl == dimmutable ? _value.rawUrl : rawUrl as String?,
        nestedNavTypeName: nestedNavTypeName == dimmutable
            ? _value.nestedNavTypeName
            : nestedNavTypeName as String?,
        processedNested: processedNested == dimmutable
            ? _value.processedNested
            : processedNested as bool));
  }
}

abstract class _$NavPayloadCopyWith<O> implements $NavPayloadCopyWith<O> {
  factory _$NavPayloadCopyWith(NavPayload value, O Function(NavPayload) then) =
      __$NavPayloadCopyWithImpl<O>;
  O call({String? rawUrl, String? nestedNavTypeName, bool processedNested});
}

class __$NavPayloadCopyWithImpl<O> extends _$NavPayloadCopyWithImpl<O>
    implements _$NavPayloadCopyWith<O> {
  __$NavPayloadCopyWithImpl(NavPayload _value, O Function(NavPayload) _then)
      : super(_value, (v) => _then(v));

  @override
  NavPayload get _value => super._value;

  @override
  O call(
      {Object? rawUrl = dimmutable,
      Object? nestedNavTypeName = dimmutable,
      Object? processedNested = dimmutable}) {
    return _then(NavPayload(
        rawUrl: rawUrl == dimmutable ? _value.rawUrl : rawUrl as String?,
        nestedNavTypeName: nestedNavTypeName == dimmutable
            ? _value.nestedNavTypeName
            : nestedNavTypeName as String?,
        processedNested: processedNested == dimmutable
            ? _value.processedNested
            : processedNested as bool));
  }
}
