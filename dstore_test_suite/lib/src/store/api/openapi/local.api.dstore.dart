// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local.dart';

// **************************************************************************
// OpenApiGenerator
// **************************************************************************

@JsonSerializable()
class ErrorObject {
  final int code;

  final String message;

  @JsonKey(ignore: true)
  _$ErrorObjectCopyWith<ErrorObject> get copyWith =>
      __$ErrorObjectCopyWithImpl<ErrorObject>(this, IdentityFn);

  const ErrorObject({required this.code, required this.message});

  factory ErrorObject.fromJson(Map<String, dynamic> json) =>
      _$ErrorObjectFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorObjectToJson(this);

  static ErrorObject fromJsonStatic(int status, dynamic value) =>
      _$ErrorObjectFromJson(value as Map<String, dynamic>);

  static dynamic toJsonStatic(int status, ErrorObject input) => input.toJson();

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is ErrorObject && o.code == code && o.message == message;
  }

  @override
  int get hashCode => code.hashCode ^ message.hashCode;

  @override
  String toString() =>
      "ErrorObject(code: ${this.code}, message: ${this.message})";
}

abstract class $ErrorObjectCopyWith<O> {
  factory $ErrorObjectCopyWith(
          ErrorObject value, O Function(ErrorObject) then) =
      _$ErrorObjectCopyWithImpl<O>;
  O call({int code, String message});
}

class _$ErrorObjectCopyWithImpl<O> implements $ErrorObjectCopyWith<O> {
  final ErrorObject _value;
  final O Function(ErrorObject) _then;
  _$ErrorObjectCopyWithImpl(this._value, this._then);

  @override
  O call({Object? code = dimmutable, Object? message = dimmutable}) {
    return _then(_value.copyWith(
        code: code == dimmutable ? _value.code : code as int,
        message: message == dimmutable ? _value.message : message as String));
  }
}

abstract class _$ErrorObjectCopyWith<O> implements $ErrorObjectCopyWith<O> {
  factory _$ErrorObjectCopyWith(
          ErrorObject value, O Function(ErrorObject) then) =
      __$ErrorObjectCopyWithImpl<O>;
  O call({int code, String message});
}

class __$ErrorObjectCopyWithImpl<O> extends _$ErrorObjectCopyWithImpl<O>
    implements _$ErrorObjectCopyWith<O> {
  __$ErrorObjectCopyWithImpl(ErrorObject _value, O Function(ErrorObject) _then)
      : super(_value, (v) => _then(v));

  @override
  ErrorObject get _value => super._value;

  @override
  O call({Object? code = dimmutable, Object? message = dimmutable}) {
    return _then(ErrorObject(
        code: code == dimmutable ? _value.code : code as int,
        message: message == dimmutable ? _value.message : message as String));
  }
}

String helloPingResponse_SuccessSerializer(int status, String input) => input;

String helloPingResponse_SuccessDeserializer(int status, dynamic input) =>
    input.toString();

String helloPingResponse_ErrorSerializer(int status, String input) => input;

String helloPingResponse_ErrorDeserializer(int status, dynamic input) =>
    input.toString();

@HttpRequest(
    method: "GET",
    url: "http://localhost:8080/",
    responseType: HttpResponseType.STRING,
    responseSerializer: helloPingResponse_SuccessSerializer,
    responseDeserializer: helloPingResponse_SuccessDeserializer,
    errorDeserializer: helloPingResponse_ErrorDeserializer)
typedef helloPing = HttpField<Null, String, String>;
