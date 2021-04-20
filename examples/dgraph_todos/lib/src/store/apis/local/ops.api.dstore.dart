// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ops.dart';

// **************************************************************************
// GraphqlOpsGenerator
// **************************************************************************

@JsonSerializable()
class Hello_todoData {
  final Hello_todoData_todo? todo;

  @JsonKey(ignore: true)
  _$Hello_todoDataCopyWith<Hello_todoData> get copyWith =>
      __$Hello_todoDataCopyWithImpl<Hello_todoData>(this, IdentityFn);

  const Hello_todoData({required this.todo});

  factory Hello_todoData.fromJson(Map<String, dynamic> json) =>
      _$Hello_todoDataFromJson(json);

  Map<String, dynamic> toJson() => _$Hello_todoDataToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is Hello_todoData && o.todo == todo;
  }

  @override
  int get hashCode => todo.hashCode;

  @override
  String toString() => "Hello_todoData(todo: ${this.todo})";
}

abstract class $Hello_todoDataCopyWith<O> {
  factory $Hello_todoDataCopyWith(
          Hello_todoData value, O Function(Hello_todoData) then) =
      _$Hello_todoDataCopyWithImpl<O>;
  O call({Hello_todoData_todo? todo});
}

class _$Hello_todoDataCopyWithImpl<O> implements $Hello_todoDataCopyWith<O> {
  final Hello_todoData _value;
  final O Function(Hello_todoData) _then;
  _$Hello_todoDataCopyWithImpl(this._value, this._then);

  @override
  O call({Object? todo = dimmutable}) {
    return _then(_value.copyWith(
        todo: todo == dimmutable ? _value.todo : todo as Hello_todoData_todo?));
  }
}

abstract class _$Hello_todoDataCopyWith<O>
    implements $Hello_todoDataCopyWith<O> {
  factory _$Hello_todoDataCopyWith(
          Hello_todoData value, O Function(Hello_todoData) then) =
      __$Hello_todoDataCopyWithImpl<O>;
  O call({Hello_todoData_todo? todo});
}

class __$Hello_todoDataCopyWithImpl<O> extends _$Hello_todoDataCopyWithImpl<O>
    implements _$Hello_todoDataCopyWith<O> {
  __$Hello_todoDataCopyWithImpl(
      Hello_todoData _value, O Function(Hello_todoData) _then)
      : super(_value, (v) => _then(v));

  @override
  Hello_todoData get _value => super._value;

  @override
  O call({Object? todo = dimmutable}) {
    return _then(Hello_todoData(
        todo: todo == dimmutable ? _value.todo : todo as Hello_todoData_todo?));
  }
}

@JsonSerializable()
class Hello_todoData_todo {
  final String? text;

  @JsonKey(ignore: true)
  _$Hello_todoData_todoCopyWith<Hello_todoData_todo> get copyWith =>
      __$Hello_todoData_todoCopyWithImpl<Hello_todoData_todo>(this, IdentityFn);

  const Hello_todoData_todo({required this.text});

  factory Hello_todoData_todo.fromJson(Map<String, dynamic> json) =>
      _$Hello_todoData_todoFromJson(json);

  Map<String, dynamic> toJson() => _$Hello_todoData_todoToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is Hello_todoData_todo && o.text == text;
  }

  @override
  int get hashCode => text.hashCode;

  @override
  String toString() => "Hello_todoData_todo(text: ${this.text})";
}

abstract class $Hello_todoData_todoCopyWith<O> {
  factory $Hello_todoData_todoCopyWith(
          Hello_todoData_todo value, O Function(Hello_todoData_todo) then) =
      _$Hello_todoData_todoCopyWithImpl<O>;
  O call({String? text});
}

class _$Hello_todoData_todoCopyWithImpl<O>
    implements $Hello_todoData_todoCopyWith<O> {
  final Hello_todoData_todo _value;
  final O Function(Hello_todoData_todo) _then;
  _$Hello_todoData_todoCopyWithImpl(this._value, this._then);

  @override
  O call({Object? text = dimmutable}) {
    return _then(_value.copyWith(
        text: text == dimmutable ? _value.text : text as String?));
  }
}

abstract class _$Hello_todoData_todoCopyWith<O>
    implements $Hello_todoData_todoCopyWith<O> {
  factory _$Hello_todoData_todoCopyWith(
          Hello_todoData_todo value, O Function(Hello_todoData_todo) then) =
      __$Hello_todoData_todoCopyWithImpl<O>;
  O call({String? text});
}

class __$Hello_todoData_todoCopyWithImpl<O>
    extends _$Hello_todoData_todoCopyWithImpl<O>
    implements _$Hello_todoData_todoCopyWith<O> {
  __$Hello_todoData_todoCopyWithImpl(
      Hello_todoData_todo _value, O Function(Hello_todoData_todo) _then)
      : super(_value, (v) => _then(v));

  @override
  Hello_todoData_todo get _value => super._value;

  @override
  O call({Object? text = dimmutable}) {
    return _then(Hello_todoData_todo(
        text: text == dimmutable ? _value.text : text as String?));
  }
}

@HttpRequest(
    method: "POST",
    url: "http://localhost:4000/",
    graphqlQuery: """    query todo{
      todo {
        text
      } 
    }
  
  """,
    responseType: HttpResponseType.JSON,
    headers: {"Content_Type": "applications/josn"},
    responseSerializer: _$Hello_todoDataToJson,
    inputSerializer: GraphqlRequestInput.toJson,
    inputDeserializer: GraphqlRequestInput.fromJson,
    responseDeserializer: _$Hello_todoDataToJson)
class Hello_todo = HttpField<Null, GraphqlRequestInput, Hello_todoData, dynamic>
    with EmptyMixin;

@HttpRequest(
    method: "POST",
    url: "http://localhost:4000/",
    graphqlQuery: """    query todo{
      todo {
        text
      } 
    }
  
  """,
    responseType: HttpResponseType.JSON,
    headers: {"Content_Type": "applications/josn"},
    responseSerializer: _$Hello_todoDataToJson,
    inputSerializer: GraphqlRequestInput.toJson,
    inputDeserializer: GraphqlRequestInput.fromJson,
    responseDeserializer: _$Hello_todoDataToJson)
class Hello_todoT<T> = HttpField<Null, GraphqlRequestInput, T, dynamic>
    with EmptyMixin;
