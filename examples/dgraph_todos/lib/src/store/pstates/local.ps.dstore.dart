// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local.dart';

// **************************************************************************
// PStateGenerator
// **************************************************************************

@immutable
class Local extends PStateModel<Local> {
  final Hello_todo todos;

  _$LocalCopyWith<Local> get copyWith =>
      __$LocalCopyWithImpl<Local>(this, IdentityFn);

  Local({this.todos = const Hello_todo()});

  @override
  Local copyWithMap(Map<String, dynamic> map) => Local(
      todos:
          map.containsKey("todos") ? map["todos"] as Hello_todo : this.todos);

  Map<String, dynamic> toMap() => <String, dynamic>{"todos": this.todos};

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is Local && o.todos == todos;
  }

  @override
  int get hashCode => todos.hashCode;

  @override
  String toString() => "Local(todos: ${this.todos})";
}

abstract class $LocalCopyWith<O> {
  factory $LocalCopyWith(Local value, O Function(Local) then) =
      _$LocalCopyWithImpl<O>;
  O call({Hello_todo todos});
}

class _$LocalCopyWithImpl<O> implements $LocalCopyWith<O> {
  final Local _value;
  final O Function(Local) _then;
  _$LocalCopyWithImpl(this._value, this._then);

  @override
  O call({Object? todos = dimmutable}) {
    return _then(_value.copyWith(
        todos: todos == dimmutable ? _value.todos : todos as Hello_todo));
  }
}

abstract class _$LocalCopyWith<O> implements $LocalCopyWith<O> {
  factory _$LocalCopyWith(Local value, O Function(Local) then) =
      __$LocalCopyWithImpl<O>;
  O call({Hello_todo todos});
}

class __$LocalCopyWithImpl<O> extends _$LocalCopyWithImpl<O>
    implements _$LocalCopyWith<O> {
  __$LocalCopyWithImpl(Local _value, O Function(Local) _then)
      : super(_value, (v) => _then(v));

  @override
  Local get _value => super._value;

  @override
  O call({Object? todos = dimmutable}) {
    return _then(
        Local(todos: todos == dimmutable ? _value.todos : todos as Hello_todo));
  }
}

const _Local_FullPath = "/store/pstates/local/Local";

abstract class LocalActions {
  static Action<Hello_todo> todos(
      {bool abortable = false,
      bool offline = false,
      Map<String, dynamic>? headers,
      Hello_todoData? optimisticResponse,
      Hello_todo? mock,
      Duration? debounce}) {
    headers = <String, dynamic>{
      ...<String, String>{"Content_Type": "applications/josn"},
      ...headers ?? <String, String>{}
    };
    return Action<Hello_todo>(
        name: "todos",
        type: _Local_FullPath,
        http: HttpPayload<GraphqlRequestInput<Null>, Hello_todoData, dynamic,
                dynamic>(
            data: GraphqlRequestInput(query: """query todo{
      todo {
        text
      } 
    }"""),
            abortable: abortable,
            offline: offline,
            headers: headers,
            optimisticResponse: optimisticResponse,
            url: "http://localhost:4000/",
            method: "POST",
            responseType: HttpResponseType.JSON),
        debounce: debounce);
  }
}

Local Local_DS() => Local(todos: Hello_todo());

final LocalMeta =
    PStateMeta<Local>(type: _Local_FullPath, ds: Local_DS, httpMetaMap: {
  "todos":
      HttpMeta<GraphqlRequestInput<Null>, Hello_todoData, dynamic, dynamic>(
          inputSerializer: GraphqlRequestInput.toJson,
          inputDeserializer: Hello_todoInputDeserializer,
          responseSerializer: Hello_todoDataSerializer,
          responseDeserializer: Hello_todoDataDeserializer)
});
