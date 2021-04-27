// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// GraphqlSchemaGenerator
// **************************************************************************

enum __TypeKind {
  SCALAR,
  OBJECT,
  INTERFACE,
  UNION,
  ENUM,
  INPUT_OBJECT,
  LIST,
  NON_NULL
}
enum PostHasFilter { title, text, score, completed, datePublished, author }
enum HTTPMethod { GET, POST, PUT, PATCH, DELETE }
enum PostOrderable { title, text, score, datePublished }
enum Mode { BATCH, SINGLE }
enum TaskHasFilter { title, completed, user }
enum AuthorHasFilter { name, posts, friends, n }
enum UserHasFilter { username, name, tasks }
enum DgraphIndex {
  int,
  int64,
  float,
  bool,
  hash,
  exact,
  term,
  fulltext,
  trigram,
  regexp,
  year,
  month,
  day,
  hour,
  geo
}
enum UserOrderable { username, name }
enum TaskOrderable { title }
enum __DirectiveLocation {
  QUERY,
  MUTATION,
  SUBSCRIPTION,
  FIELD,
  FRAGMENT_DEFINITION,
  FRAGMENT_SPREAD,
  INLINE_FRAGMENT,
  SCHEMA,
  SCALAR,
  OBJECT,
  FIELD_DEFINITION,
  ARGUMENT_DEFINITION,
  INTERFACE,
  UNION,
  ENUM,
  ENUM_VALUE,
  INPUT_OBJECT,
  INPUT_FIELD_DEFINITION
}
enum AuthorOrderable { name, n }

@JsonSerializable()
class UpdateAuthorInput {
  final dynamic filter;

  final dynamic? set;

  final dynamic? remove;

  @JsonKey(ignore: true)
  _$UpdateAuthorInputCopyWith<UpdateAuthorInput> get copyWith =>
      __$UpdateAuthorInputCopyWithImpl<UpdateAuthorInput>(this, IdentityFn);

  const UpdateAuthorInput({required this.filter, this.set, this.remove});

  factory UpdateAuthorInput.fromJson(Map<String, dynamic> json) =>
      _$UpdateAuthorInputFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateAuthorInputToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is UpdateAuthorInput &&
        o.filter == filter &&
        o.set == set &&
        o.remove == remove;
  }

  @override
  int get hashCode => filter.hashCode ^ set.hashCode ^ remove.hashCode;

  @override
  String toString() =>
      "UpdateAuthorInput(filter: ${this.filter}, set: ${this.set}, remove: ${this.remove})";
}

abstract class $UpdateAuthorInputCopyWith<O> {
  factory $UpdateAuthorInputCopyWith(
          UpdateAuthorInput value, O Function(UpdateAuthorInput) then) =
      _$UpdateAuthorInputCopyWithImpl<O>;
  O call({dynamic filter, dynamic? set, dynamic? remove});
}

class _$UpdateAuthorInputCopyWithImpl<O>
    implements $UpdateAuthorInputCopyWith<O> {
  final UpdateAuthorInput _value;
  final O Function(UpdateAuthorInput) _then;
  _$UpdateAuthorInputCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? filter = dimmutable,
      Object? set = dimmutable,
      Object? remove = dimmutable}) {
    return _then(_value.copyWith(
        filter: filter == dimmutable ? _value.filter : filter as dynamic,
        set: set == dimmutable ? _value.set : set as dynamic?,
        remove: remove == dimmutable ? _value.remove : remove as dynamic?));
  }
}

abstract class _$UpdateAuthorInputCopyWith<O>
    implements $UpdateAuthorInputCopyWith<O> {
  factory _$UpdateAuthorInputCopyWith(
          UpdateAuthorInput value, O Function(UpdateAuthorInput) then) =
      __$UpdateAuthorInputCopyWithImpl<O>;
  O call({dynamic filter, dynamic? set, dynamic? remove});
}

class __$UpdateAuthorInputCopyWithImpl<O>
    extends _$UpdateAuthorInputCopyWithImpl<O>
    implements _$UpdateAuthorInputCopyWith<O> {
  __$UpdateAuthorInputCopyWithImpl(
      UpdateAuthorInput _value, O Function(UpdateAuthorInput) _then)
      : super(_value, (v) => _then(v));

  @override
  UpdateAuthorInput get _value => super._value;

  @override
  O call(
      {Object? filter = dimmutable,
      Object? set = dimmutable,
      Object? remove = dimmutable}) {
    return _then(UpdateAuthorInput(
        filter: filter == dimmutable ? _value.filter : filter as dynamic,
        set: set == dimmutable ? _value.set : set as dynamic?,
        remove: remove == dimmutable ? _value.remove : remove as dynamic?));
  }
}

@JsonSerializable()
class AddTaskInput {
  final String title;

  final bool completed;

  final dynamic user;

  @JsonKey(ignore: true)
  _$AddTaskInputCopyWith<AddTaskInput> get copyWith =>
      __$AddTaskInputCopyWithImpl<AddTaskInput>(this, IdentityFn);

  const AddTaskInput(
      {required this.title, required this.completed, required this.user});

  factory AddTaskInput.fromJson(Map<String, dynamic> json) =>
      _$AddTaskInputFromJson(json);

  Map<String, dynamic> toJson() => _$AddTaskInputToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is AddTaskInput &&
        o.title == title &&
        o.completed == completed &&
        o.user == user;
  }

  @override
  int get hashCode => title.hashCode ^ completed.hashCode ^ user.hashCode;

  @override
  String toString() =>
      "AddTaskInput(title: ${this.title}, completed: ${this.completed}, user: ${this.user})";
}

abstract class $AddTaskInputCopyWith<O> {
  factory $AddTaskInputCopyWith(
          AddTaskInput value, O Function(AddTaskInput) then) =
      _$AddTaskInputCopyWithImpl<O>;
  O call({String title, bool completed, dynamic user});
}

class _$AddTaskInputCopyWithImpl<O> implements $AddTaskInputCopyWith<O> {
  final AddTaskInput _value;
  final O Function(AddTaskInput) _then;
  _$AddTaskInputCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? title = dimmutable,
      Object? completed = dimmutable,
      Object? user = dimmutable}) {
    return _then(_value.copyWith(
        title: title == dimmutable ? _value.title : title as String,
        completed:
            completed == dimmutable ? _value.completed : completed as bool,
        user: user == dimmutable ? _value.user : user as dynamic));
  }
}

abstract class _$AddTaskInputCopyWith<O> implements $AddTaskInputCopyWith<O> {
  factory _$AddTaskInputCopyWith(
          AddTaskInput value, O Function(AddTaskInput) then) =
      __$AddTaskInputCopyWithImpl<O>;
  O call({String title, bool completed, dynamic user});
}

class __$AddTaskInputCopyWithImpl<O> extends _$AddTaskInputCopyWithImpl<O>
    implements _$AddTaskInputCopyWith<O> {
  __$AddTaskInputCopyWithImpl(
      AddTaskInput _value, O Function(AddTaskInput) _then)
      : super(_value, (v) => _then(v));

  @override
  AddTaskInput get _value => super._value;

  @override
  O call(
      {Object? title = dimmutable,
      Object? completed = dimmutable,
      Object? user = dimmutable}) {
    return _then(AddTaskInput(
        title: title == dimmutable ? _value.title : title as String,
        completed:
            completed == dimmutable ? _value.completed : completed as bool,
        user: user == dimmutable ? _value.user : user as dynamic));
  }
}

@JsonSerializable()
class AddUserInput {
  final String username;

  final String? name;

  final List<dynamic?>? tasks;

  @JsonKey(ignore: true)
  _$AddUserInputCopyWith<AddUserInput> get copyWith =>
      __$AddUserInputCopyWithImpl<AddUserInput>(this, IdentityFn);

  const AddUserInput({required this.username, this.name, this.tasks});

  factory AddUserInput.fromJson(Map<String, dynamic> json) =>
      _$AddUserInputFromJson(json);

  Map<String, dynamic> toJson() => _$AddUserInputToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is AddUserInput &&
        o.username == username &&
        o.name == name &&
        o.tasks == tasks;
  }

  @override
  int get hashCode => username.hashCode ^ name.hashCode ^ tasks.hashCode;

  @override
  String toString() =>
      "AddUserInput(username: ${this.username}, name: ${this.name}, tasks: ${this.tasks})";
}

abstract class $AddUserInputCopyWith<O> {
  factory $AddUserInputCopyWith(
          AddUserInput value, O Function(AddUserInput) then) =
      _$AddUserInputCopyWithImpl<O>;
  O call({String username, String? name, List<dynamic?>? tasks});
}

class _$AddUserInputCopyWithImpl<O> implements $AddUserInputCopyWith<O> {
  final AddUserInput _value;
  final O Function(AddUserInput) _then;
  _$AddUserInputCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? username = dimmutable,
      Object? name = dimmutable,
      Object? tasks = dimmutable}) {
    return _then(_value.copyWith(
        username: username == dimmutable ? _value.username : username as String,
        name: name == dimmutable ? _value.name : name as String?,
        tasks: tasks == dimmutable ? _value.tasks : tasks as List<dynamic?>?));
  }
}

abstract class _$AddUserInputCopyWith<O> implements $AddUserInputCopyWith<O> {
  factory _$AddUserInputCopyWith(
          AddUserInput value, O Function(AddUserInput) then) =
      __$AddUserInputCopyWithImpl<O>;
  O call({String username, String? name, List<dynamic?>? tasks});
}

class __$AddUserInputCopyWithImpl<O> extends _$AddUserInputCopyWithImpl<O>
    implements _$AddUserInputCopyWith<O> {
  __$AddUserInputCopyWithImpl(
      AddUserInput _value, O Function(AddUserInput) _then)
      : super(_value, (v) => _then(v));

  @override
  AddUserInput get _value => super._value;

  @override
  O call(
      {Object? username = dimmutable,
      Object? name = dimmutable,
      Object? tasks = dimmutable}) {
    return _then(AddUserInput(
        username: username == dimmutable ? _value.username : username as String,
        name: name == dimmutable ? _value.name : name as String?,
        tasks: tasks == dimmutable ? _value.tasks : tasks as List<dynamic?>?));
  }
}

@JsonSerializable()
class CustomHTTP {
  final String url;

  final dynamic method;

  final String? body;

  final String? graphql;

  final dynamic? mode;

  final List<String>? forwardHeaders;

  final List<String>? secretHeaders;

  final List<String>? introspectionHeaders;

  final bool? skipIntrospection;

  @JsonKey(ignore: true)
  _$CustomHTTPCopyWith<CustomHTTP> get copyWith =>
      __$CustomHTTPCopyWithImpl<CustomHTTP>(this, IdentityFn);

  const CustomHTTP(
      {required this.url,
      required this.method,
      this.body,
      this.graphql,
      this.mode,
      this.forwardHeaders,
      this.secretHeaders,
      this.introspectionHeaders,
      this.skipIntrospection});

  factory CustomHTTP.fromJson(Map<String, dynamic> json) =>
      _$CustomHTTPFromJson(json);

  Map<String, dynamic> toJson() => _$CustomHTTPToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is CustomHTTP &&
        o.url == url &&
        o.method == method &&
        o.body == body &&
        o.graphql == graphql &&
        o.mode == mode &&
        o.forwardHeaders == forwardHeaders &&
        o.secretHeaders == secretHeaders &&
        o.introspectionHeaders == introspectionHeaders &&
        o.skipIntrospection == skipIntrospection;
  }

  @override
  int get hashCode =>
      url.hashCode ^
      method.hashCode ^
      body.hashCode ^
      graphql.hashCode ^
      mode.hashCode ^
      forwardHeaders.hashCode ^
      secretHeaders.hashCode ^
      introspectionHeaders.hashCode ^
      skipIntrospection.hashCode;

  @override
  String toString() =>
      "CustomHTTP(url: ${this.url}, method: ${this.method}, body: ${this.body}, graphql: ${this.graphql}, mode: ${this.mode}, forwardHeaders: ${this.forwardHeaders}, secretHeaders: ${this.secretHeaders}, introspectionHeaders: ${this.introspectionHeaders}, skipIntrospection: ${this.skipIntrospection})";
}

abstract class $CustomHTTPCopyWith<O> {
  factory $CustomHTTPCopyWith(CustomHTTP value, O Function(CustomHTTP) then) =
      _$CustomHTTPCopyWithImpl<O>;
  O call(
      {String url,
      dynamic method,
      String? body,
      String? graphql,
      dynamic? mode,
      List<String>? forwardHeaders,
      List<String>? secretHeaders,
      List<String>? introspectionHeaders,
      bool? skipIntrospection});
}

class _$CustomHTTPCopyWithImpl<O> implements $CustomHTTPCopyWith<O> {
  final CustomHTTP _value;
  final O Function(CustomHTTP) _then;
  _$CustomHTTPCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? url = dimmutable,
      Object? method = dimmutable,
      Object? body = dimmutable,
      Object? graphql = dimmutable,
      Object? mode = dimmutable,
      Object? forwardHeaders = dimmutable,
      Object? secretHeaders = dimmutable,
      Object? introspectionHeaders = dimmutable,
      Object? skipIntrospection = dimmutable}) {
    return _then(_value.copyWith(
        url: url == dimmutable ? _value.url : url as String,
        method: method == dimmutable ? _value.method : method as dynamic,
        body: body == dimmutable ? _value.body : body as String?,
        graphql: graphql == dimmutable ? _value.graphql : graphql as String?,
        mode: mode == dimmutable ? _value.mode : mode as dynamic?,
        forwardHeaders: forwardHeaders == dimmutable
            ? _value.forwardHeaders
            : forwardHeaders as List<String>?,
        secretHeaders: secretHeaders == dimmutable
            ? _value.secretHeaders
            : secretHeaders as List<String>?,
        introspectionHeaders: introspectionHeaders == dimmutable
            ? _value.introspectionHeaders
            : introspectionHeaders as List<String>?,
        skipIntrospection: skipIntrospection == dimmutable
            ? _value.skipIntrospection
            : skipIntrospection as bool?));
  }
}

abstract class _$CustomHTTPCopyWith<O> implements $CustomHTTPCopyWith<O> {
  factory _$CustomHTTPCopyWith(CustomHTTP value, O Function(CustomHTTP) then) =
      __$CustomHTTPCopyWithImpl<O>;
  O call(
      {String url,
      dynamic method,
      String? body,
      String? graphql,
      dynamic? mode,
      List<String>? forwardHeaders,
      List<String>? secretHeaders,
      List<String>? introspectionHeaders,
      bool? skipIntrospection});
}

class __$CustomHTTPCopyWithImpl<O> extends _$CustomHTTPCopyWithImpl<O>
    implements _$CustomHTTPCopyWith<O> {
  __$CustomHTTPCopyWithImpl(CustomHTTP _value, O Function(CustomHTTP) _then)
      : super(_value, (v) => _then(v));

  @override
  CustomHTTP get _value => super._value;

  @override
  O call(
      {Object? url = dimmutable,
      Object? method = dimmutable,
      Object? body = dimmutable,
      Object? graphql = dimmutable,
      Object? mode = dimmutable,
      Object? forwardHeaders = dimmutable,
      Object? secretHeaders = dimmutable,
      Object? introspectionHeaders = dimmutable,
      Object? skipIntrospection = dimmutable}) {
    return _then(CustomHTTP(
        url: url == dimmutable ? _value.url : url as String,
        method: method == dimmutable ? _value.method : method as dynamic,
        body: body == dimmutable ? _value.body : body as String?,
        graphql: graphql == dimmutable ? _value.graphql : graphql as String?,
        mode: mode == dimmutable ? _value.mode : mode as dynamic?,
        forwardHeaders: forwardHeaders == dimmutable
            ? _value.forwardHeaders
            : forwardHeaders as List<String>?,
        secretHeaders: secretHeaders == dimmutable
            ? _value.secretHeaders
            : secretHeaders as List<String>?,
        introspectionHeaders: introspectionHeaders == dimmutable
            ? _value.introspectionHeaders
            : introspectionHeaders as List<String>?,
        skipIntrospection: skipIntrospection == dimmutable
            ? _value.skipIntrospection
            : skipIntrospection as bool?));
  }
}

@JsonSerializable()
class IntersectsFilter {
  final dynamic? polygon;

  final dynamic? multiPolygon;

  @JsonKey(ignore: true)
  _$IntersectsFilterCopyWith<IntersectsFilter> get copyWith =>
      __$IntersectsFilterCopyWithImpl<IntersectsFilter>(this, IdentityFn);

  const IntersectsFilter({this.polygon, this.multiPolygon});

  factory IntersectsFilter.fromJson(Map<String, dynamic> json) =>
      _$IntersectsFilterFromJson(json);

  Map<String, dynamic> toJson() => _$IntersectsFilterToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is IntersectsFilter &&
        o.polygon == polygon &&
        o.multiPolygon == multiPolygon;
  }

  @override
  int get hashCode => polygon.hashCode ^ multiPolygon.hashCode;

  @override
  String toString() =>
      "IntersectsFilter(polygon: ${this.polygon}, multiPolygon: ${this.multiPolygon})";
}

abstract class $IntersectsFilterCopyWith<O> {
  factory $IntersectsFilterCopyWith(
          IntersectsFilter value, O Function(IntersectsFilter) then) =
      _$IntersectsFilterCopyWithImpl<O>;
  O call({dynamic? polygon, dynamic? multiPolygon});
}

class _$IntersectsFilterCopyWithImpl<O>
    implements $IntersectsFilterCopyWith<O> {
  final IntersectsFilter _value;
  final O Function(IntersectsFilter) _then;
  _$IntersectsFilterCopyWithImpl(this._value, this._then);

  @override
  O call({Object? polygon = dimmutable, Object? multiPolygon = dimmutable}) {
    return _then(_value.copyWith(
        polygon: polygon == dimmutable ? _value.polygon : polygon as dynamic?,
        multiPolygon: multiPolygon == dimmutable
            ? _value.multiPolygon
            : multiPolygon as dynamic?));
  }
}

abstract class _$IntersectsFilterCopyWith<O>
    implements $IntersectsFilterCopyWith<O> {
  factory _$IntersectsFilterCopyWith(
          IntersectsFilter value, O Function(IntersectsFilter) then) =
      __$IntersectsFilterCopyWithImpl<O>;
  O call({dynamic? polygon, dynamic? multiPolygon});
}

class __$IntersectsFilterCopyWithImpl<O>
    extends _$IntersectsFilterCopyWithImpl<O>
    implements _$IntersectsFilterCopyWith<O> {
  __$IntersectsFilterCopyWithImpl(
      IntersectsFilter _value, O Function(IntersectsFilter) _then)
      : super(_value, (v) => _then(v));

  @override
  IntersectsFilter get _value => super._value;

  @override
  O call({Object? polygon = dimmutable, Object? multiPolygon = dimmutable}) {
    return _then(IntersectsFilter(
        polygon: polygon == dimmutable ? _value.polygon : polygon as dynamic?,
        multiPolygon: multiPolygon == dimmutable
            ? _value.multiPolygon
            : multiPolygon as dynamic?));
  }
}

@JsonSerializable()
class AddPostInput {
  final String title;

  final String? text;

  final double? score;

  final bool? completed;

  final dynamic? datePublished;

  final dynamic author;

  @JsonKey(ignore: true)
  _$AddPostInputCopyWith<AddPostInput> get copyWith =>
      __$AddPostInputCopyWithImpl<AddPostInput>(this, IdentityFn);

  const AddPostInput(
      {required this.title,
      this.text,
      this.score,
      this.completed,
      this.datePublished,
      required this.author});

  factory AddPostInput.fromJson(Map<String, dynamic> json) =>
      _$AddPostInputFromJson(json);

  Map<String, dynamic> toJson() => _$AddPostInputToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is AddPostInput &&
        o.title == title &&
        o.text == text &&
        o.score == score &&
        o.completed == completed &&
        o.datePublished == datePublished &&
        o.author == author;
  }

  @override
  int get hashCode =>
      title.hashCode ^
      text.hashCode ^
      score.hashCode ^
      completed.hashCode ^
      datePublished.hashCode ^
      author.hashCode;

  @override
  String toString() =>
      "AddPostInput(title: ${this.title}, text: ${this.text}, score: ${this.score}, completed: ${this.completed}, datePublished: ${this.datePublished}, author: ${this.author})";
}

abstract class $AddPostInputCopyWith<O> {
  factory $AddPostInputCopyWith(
          AddPostInput value, O Function(AddPostInput) then) =
      _$AddPostInputCopyWithImpl<O>;
  O call(
      {String title,
      String? text,
      double? score,
      bool? completed,
      dynamic? datePublished,
      dynamic author});
}

class _$AddPostInputCopyWithImpl<O> implements $AddPostInputCopyWith<O> {
  final AddPostInput _value;
  final O Function(AddPostInput) _then;
  _$AddPostInputCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? title = dimmutable,
      Object? text = dimmutable,
      Object? score = dimmutable,
      Object? completed = dimmutable,
      Object? datePublished = dimmutable,
      Object? author = dimmutable}) {
    return _then(_value.copyWith(
        title: title == dimmutable ? _value.title : title as String,
        text: text == dimmutable ? _value.text : text as String?,
        score: score == dimmutable ? _value.score : score as double?,
        completed:
            completed == dimmutable ? _value.completed : completed as bool?,
        datePublished: datePublished == dimmutable
            ? _value.datePublished
            : datePublished as dynamic?,
        author: author == dimmutable ? _value.author : author as dynamic));
  }
}

abstract class _$AddPostInputCopyWith<O> implements $AddPostInputCopyWith<O> {
  factory _$AddPostInputCopyWith(
          AddPostInput value, O Function(AddPostInput) then) =
      __$AddPostInputCopyWithImpl<O>;
  O call(
      {String title,
      String? text,
      double? score,
      bool? completed,
      dynamic? datePublished,
      dynamic author});
}

class __$AddPostInputCopyWithImpl<O> extends _$AddPostInputCopyWithImpl<O>
    implements _$AddPostInputCopyWith<O> {
  __$AddPostInputCopyWithImpl(
      AddPostInput _value, O Function(AddPostInput) _then)
      : super(_value, (v) => _then(v));

  @override
  AddPostInput get _value => super._value;

  @override
  O call(
      {Object? title = dimmutable,
      Object? text = dimmutable,
      Object? score = dimmutable,
      Object? completed = dimmutable,
      Object? datePublished = dimmutable,
      Object? author = dimmutable}) {
    return _then(AddPostInput(
        title: title == dimmutable ? _value.title : title as String,
        text: text == dimmutable ? _value.text : text as String?,
        score: score == dimmutable ? _value.score : score as double?,
        completed:
            completed == dimmutable ? _value.completed : completed as bool?,
        datePublished: datePublished == dimmutable
            ? _value.datePublished
            : datePublished as dynamic?,
        author: author == dimmutable ? _value.author : author as dynamic));
  }
}

@JsonSerializable()
class TaskOrder {
  final dynamic? asc;

  final dynamic? desc;

  final dynamic? then;

  @JsonKey(ignore: true)
  _$TaskOrderCopyWith<TaskOrder> get copyWith =>
      __$TaskOrderCopyWithImpl<TaskOrder>(this, IdentityFn);

  const TaskOrder({this.asc, this.desc, this.then});

  factory TaskOrder.fromJson(Map<String, dynamic> json) =>
      _$TaskOrderFromJson(json);

  Map<String, dynamic> toJson() => _$TaskOrderToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is TaskOrder && o.asc == asc && o.desc == desc && o.then == then;
  }

  @override
  int get hashCode => asc.hashCode ^ desc.hashCode ^ then.hashCode;

  @override
  String toString() =>
      "TaskOrder(asc: ${this.asc}, desc: ${this.desc}, then: ${this.then})";
}

abstract class $TaskOrderCopyWith<O> {
  factory $TaskOrderCopyWith(TaskOrder value, O Function(TaskOrder) then) =
      _$TaskOrderCopyWithImpl<O>;
  O call({dynamic? asc, dynamic? desc, dynamic? then});
}

class _$TaskOrderCopyWithImpl<O> implements $TaskOrderCopyWith<O> {
  final TaskOrder _value;
  final O Function(TaskOrder) _then;
  _$TaskOrderCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? asc = dimmutable,
      Object? desc = dimmutable,
      Object? then = dimmutable}) {
    return _then(_value.copyWith(
        asc: asc == dimmutable ? _value.asc : asc as dynamic?,
        desc: desc == dimmutable ? _value.desc : desc as dynamic?,
        then: then == dimmutable ? _value.then : then as dynamic?));
  }
}

abstract class _$TaskOrderCopyWith<O> implements $TaskOrderCopyWith<O> {
  factory _$TaskOrderCopyWith(TaskOrder value, O Function(TaskOrder) then) =
      __$TaskOrderCopyWithImpl<O>;
  O call({dynamic? asc, dynamic? desc, dynamic? then});
}

class __$TaskOrderCopyWithImpl<O> extends _$TaskOrderCopyWithImpl<O>
    implements _$TaskOrderCopyWith<O> {
  __$TaskOrderCopyWithImpl(TaskOrder _value, O Function(TaskOrder) _then)
      : super(_value, (v) => _then(v));

  @override
  TaskOrder get _value => super._value;

  @override
  O call(
      {Object? asc = dimmutable,
      Object? desc = dimmutable,
      Object? then = dimmutable}) {
    return _then(TaskOrder(
        asc: asc == dimmutable ? _value.asc : asc as dynamic?,
        desc: desc == dimmutable ? _value.desc : desc as dynamic?,
        then: then == dimmutable ? _value.then : then as dynamic?));
  }
}

@JsonSerializable()
class PolygonGeoFilter {
  final dynamic? near;

  final dynamic? within;

  final dynamic? contains;

  final dynamic? intersects;

  @JsonKey(ignore: true)
  _$PolygonGeoFilterCopyWith<PolygonGeoFilter> get copyWith =>
      __$PolygonGeoFilterCopyWithImpl<PolygonGeoFilter>(this, IdentityFn);

  const PolygonGeoFilter(
      {this.near, this.within, this.contains, this.intersects});

  factory PolygonGeoFilter.fromJson(Map<String, dynamic> json) =>
      _$PolygonGeoFilterFromJson(json);

  Map<String, dynamic> toJson() => _$PolygonGeoFilterToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is PolygonGeoFilter &&
        o.near == near &&
        o.within == within &&
        o.contains == contains &&
        o.intersects == intersects;
  }

  @override
  int get hashCode =>
      near.hashCode ^ within.hashCode ^ contains.hashCode ^ intersects.hashCode;

  @override
  String toString() =>
      "PolygonGeoFilter(near: ${this.near}, within: ${this.within}, contains: ${this.contains}, intersects: ${this.intersects})";
}

abstract class $PolygonGeoFilterCopyWith<O> {
  factory $PolygonGeoFilterCopyWith(
          PolygonGeoFilter value, O Function(PolygonGeoFilter) then) =
      _$PolygonGeoFilterCopyWithImpl<O>;
  O call(
      {dynamic? near, dynamic? within, dynamic? contains, dynamic? intersects});
}

class _$PolygonGeoFilterCopyWithImpl<O>
    implements $PolygonGeoFilterCopyWith<O> {
  final PolygonGeoFilter _value;
  final O Function(PolygonGeoFilter) _then;
  _$PolygonGeoFilterCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? near = dimmutable,
      Object? within = dimmutable,
      Object? contains = dimmutable,
      Object? intersects = dimmutable}) {
    return _then(_value.copyWith(
        near: near == dimmutable ? _value.near : near as dynamic?,
        within: within == dimmutable ? _value.within : within as dynamic?,
        contains:
            contains == dimmutable ? _value.contains : contains as dynamic?,
        intersects: intersects == dimmutable
            ? _value.intersects
            : intersects as dynamic?));
  }
}

abstract class _$PolygonGeoFilterCopyWith<O>
    implements $PolygonGeoFilterCopyWith<O> {
  factory _$PolygonGeoFilterCopyWith(
          PolygonGeoFilter value, O Function(PolygonGeoFilter) then) =
      __$PolygonGeoFilterCopyWithImpl<O>;
  O call(
      {dynamic? near, dynamic? within, dynamic? contains, dynamic? intersects});
}

class __$PolygonGeoFilterCopyWithImpl<O>
    extends _$PolygonGeoFilterCopyWithImpl<O>
    implements _$PolygonGeoFilterCopyWith<O> {
  __$PolygonGeoFilterCopyWithImpl(
      PolygonGeoFilter _value, O Function(PolygonGeoFilter) _then)
      : super(_value, (v) => _then(v));

  @override
  PolygonGeoFilter get _value => super._value;

  @override
  O call(
      {Object? near = dimmutable,
      Object? within = dimmutable,
      Object? contains = dimmutable,
      Object? intersects = dimmutable}) {
    return _then(PolygonGeoFilter(
        near: near == dimmutable ? _value.near : near as dynamic?,
        within: within == dimmutable ? _value.within : within as dynamic?,
        contains:
            contains == dimmutable ? _value.contains : contains as dynamic?,
        intersects: intersects == dimmutable
            ? _value.intersects
            : intersects as dynamic?));
  }
}

@JsonSerializable()
class GenerateQueryParams {
  final bool? get;

  final bool? query;

  final bool? password;

  final bool? aggregate;

  @JsonKey(ignore: true)
  _$GenerateQueryParamsCopyWith<GenerateQueryParams> get copyWith =>
      __$GenerateQueryParamsCopyWithImpl<GenerateQueryParams>(this, IdentityFn);

  const GenerateQueryParams(
      {this.get, this.query, this.password, this.aggregate});

  factory GenerateQueryParams.fromJson(Map<String, dynamic> json) =>
      _$GenerateQueryParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GenerateQueryParamsToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is GenerateQueryParams &&
        o.get == get &&
        o.query == query &&
        o.password == password &&
        o.aggregate == aggregate;
  }

  @override
  int get hashCode =>
      get.hashCode ^ query.hashCode ^ password.hashCode ^ aggregate.hashCode;

  @override
  String toString() =>
      "GenerateQueryParams(get: ${this.get}, query: ${this.query}, password: ${this.password}, aggregate: ${this.aggregate})";
}

abstract class $GenerateQueryParamsCopyWith<O> {
  factory $GenerateQueryParamsCopyWith(
          GenerateQueryParams value, O Function(GenerateQueryParams) then) =
      _$GenerateQueryParamsCopyWithImpl<O>;
  O call({bool? get, bool? query, bool? password, bool? aggregate});
}

class _$GenerateQueryParamsCopyWithImpl<O>
    implements $GenerateQueryParamsCopyWith<O> {
  final GenerateQueryParams _value;
  final O Function(GenerateQueryParams) _then;
  _$GenerateQueryParamsCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? get = dimmutable,
      Object? query = dimmutable,
      Object? password = dimmutable,
      Object? aggregate = dimmutable}) {
    return _then(_value.copyWith(
        get: get == dimmutable ? _value.get : get as bool?,
        query: query == dimmutable ? _value.query : query as bool?,
        password: password == dimmutable ? _value.password : password as bool?,
        aggregate:
            aggregate == dimmutable ? _value.aggregate : aggregate as bool?));
  }
}

abstract class _$GenerateQueryParamsCopyWith<O>
    implements $GenerateQueryParamsCopyWith<O> {
  factory _$GenerateQueryParamsCopyWith(
          GenerateQueryParams value, O Function(GenerateQueryParams) then) =
      __$GenerateQueryParamsCopyWithImpl<O>;
  O call({bool? get, bool? query, bool? password, bool? aggregate});
}

class __$GenerateQueryParamsCopyWithImpl<O>
    extends _$GenerateQueryParamsCopyWithImpl<O>
    implements _$GenerateQueryParamsCopyWith<O> {
  __$GenerateQueryParamsCopyWithImpl(
      GenerateQueryParams _value, O Function(GenerateQueryParams) _then)
      : super(_value, (v) => _then(v));

  @override
  GenerateQueryParams get _value => super._value;

  @override
  O call(
      {Object? get = dimmutable,
      Object? query = dimmutable,
      Object? password = dimmutable,
      Object? aggregate = dimmutable}) {
    return _then(GenerateQueryParams(
        get: get == dimmutable ? _value.get : get as bool?,
        query: query == dimmutable ? _value.query : query as bool?,
        password: password == dimmutable ? _value.password : password as bool?,
        aggregate:
            aggregate == dimmutable ? _value.aggregate : aggregate as bool?));
  }
}

@JsonSerializable()
class StringTermFilter {
  final String? allofterms;

  final String? anyofterms;

  @JsonKey(ignore: true)
  _$StringTermFilterCopyWith<StringTermFilter> get copyWith =>
      __$StringTermFilterCopyWithImpl<StringTermFilter>(this, IdentityFn);

  const StringTermFilter({this.allofterms, this.anyofterms});

  factory StringTermFilter.fromJson(Map<String, dynamic> json) =>
      _$StringTermFilterFromJson(json);

  Map<String, dynamic> toJson() => _$StringTermFilterToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is StringTermFilter &&
        o.allofterms == allofterms &&
        o.anyofterms == anyofterms;
  }

  @override
  int get hashCode => allofterms.hashCode ^ anyofterms.hashCode;

  @override
  String toString() =>
      "StringTermFilter(allofterms: ${this.allofterms}, anyofterms: ${this.anyofterms})";
}

abstract class $StringTermFilterCopyWith<O> {
  factory $StringTermFilterCopyWith(
          StringTermFilter value, O Function(StringTermFilter) then) =
      _$StringTermFilterCopyWithImpl<O>;
  O call({String? allofterms, String? anyofterms});
}

class _$StringTermFilterCopyWithImpl<O>
    implements $StringTermFilterCopyWith<O> {
  final StringTermFilter _value;
  final O Function(StringTermFilter) _then;
  _$StringTermFilterCopyWithImpl(this._value, this._then);

  @override
  O call({Object? allofterms = dimmutable, Object? anyofterms = dimmutable}) {
    return _then(_value.copyWith(
        allofterms: allofterms == dimmutable
            ? _value.allofterms
            : allofterms as String?,
        anyofterms: anyofterms == dimmutable
            ? _value.anyofterms
            : anyofterms as String?));
  }
}

abstract class _$StringTermFilterCopyWith<O>
    implements $StringTermFilterCopyWith<O> {
  factory _$StringTermFilterCopyWith(
          StringTermFilter value, O Function(StringTermFilter) then) =
      __$StringTermFilterCopyWithImpl<O>;
  O call({String? allofterms, String? anyofterms});
}

class __$StringTermFilterCopyWithImpl<O>
    extends _$StringTermFilterCopyWithImpl<O>
    implements _$StringTermFilterCopyWith<O> {
  __$StringTermFilterCopyWithImpl(
      StringTermFilter _value, O Function(StringTermFilter) _then)
      : super(_value, (v) => _then(v));

  @override
  StringTermFilter get _value => super._value;

  @override
  O call({Object? allofterms = dimmutable, Object? anyofterms = dimmutable}) {
    return _then(StringTermFilter(
        allofterms: allofterms == dimmutable
            ? _value.allofterms
            : allofterms as String?,
        anyofterms: anyofterms == dimmutable
            ? _value.anyofterms
            : anyofterms as String?));
  }
}

@JsonSerializable()
class PostPatch {
  final String? title;

  final String? text;

  final double? score;

  final bool? completed;

  final dynamic? datePublished;

  final dynamic? author;

  @JsonKey(ignore: true)
  _$PostPatchCopyWith<PostPatch> get copyWith =>
      __$PostPatchCopyWithImpl<PostPatch>(this, IdentityFn);

  const PostPatch(
      {this.title,
      this.text,
      this.score,
      this.completed,
      this.datePublished,
      this.author});

  factory PostPatch.fromJson(Map<String, dynamic> json) =>
      _$PostPatchFromJson(json);

  Map<String, dynamic> toJson() => _$PostPatchToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is PostPatch &&
        o.title == title &&
        o.text == text &&
        o.score == score &&
        o.completed == completed &&
        o.datePublished == datePublished &&
        o.author == author;
  }

  @override
  int get hashCode =>
      title.hashCode ^
      text.hashCode ^
      score.hashCode ^
      completed.hashCode ^
      datePublished.hashCode ^
      author.hashCode;

  @override
  String toString() =>
      "PostPatch(title: ${this.title}, text: ${this.text}, score: ${this.score}, completed: ${this.completed}, datePublished: ${this.datePublished}, author: ${this.author})";
}

abstract class $PostPatchCopyWith<O> {
  factory $PostPatchCopyWith(PostPatch value, O Function(PostPatch) then) =
      _$PostPatchCopyWithImpl<O>;
  O call(
      {String? title,
      String? text,
      double? score,
      bool? completed,
      dynamic? datePublished,
      dynamic? author});
}

class _$PostPatchCopyWithImpl<O> implements $PostPatchCopyWith<O> {
  final PostPatch _value;
  final O Function(PostPatch) _then;
  _$PostPatchCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? title = dimmutable,
      Object? text = dimmutable,
      Object? score = dimmutable,
      Object? completed = dimmutable,
      Object? datePublished = dimmutable,
      Object? author = dimmutable}) {
    return _then(_value.copyWith(
        title: title == dimmutable ? _value.title : title as String?,
        text: text == dimmutable ? _value.text : text as String?,
        score: score == dimmutable ? _value.score : score as double?,
        completed:
            completed == dimmutable ? _value.completed : completed as bool?,
        datePublished: datePublished == dimmutable
            ? _value.datePublished
            : datePublished as dynamic?,
        author: author == dimmutable ? _value.author : author as dynamic?));
  }
}

abstract class _$PostPatchCopyWith<O> implements $PostPatchCopyWith<O> {
  factory _$PostPatchCopyWith(PostPatch value, O Function(PostPatch) then) =
      __$PostPatchCopyWithImpl<O>;
  O call(
      {String? title,
      String? text,
      double? score,
      bool? completed,
      dynamic? datePublished,
      dynamic? author});
}

class __$PostPatchCopyWithImpl<O> extends _$PostPatchCopyWithImpl<O>
    implements _$PostPatchCopyWith<O> {
  __$PostPatchCopyWithImpl(PostPatch _value, O Function(PostPatch) _then)
      : super(_value, (v) => _then(v));

  @override
  PostPatch get _value => super._value;

  @override
  O call(
      {Object? title = dimmutable,
      Object? text = dimmutable,
      Object? score = dimmutable,
      Object? completed = dimmutable,
      Object? datePublished = dimmutable,
      Object? author = dimmutable}) {
    return _then(PostPatch(
        title: title == dimmutable ? _value.title : title as String?,
        text: text == dimmutable ? _value.text : text as String?,
        score: score == dimmutable ? _value.score : score as double?,
        completed:
            completed == dimmutable ? _value.completed : completed as bool?,
        datePublished: datePublished == dimmutable
            ? _value.datePublished
            : datePublished as dynamic?,
        author: author == dimmutable ? _value.author : author as dynamic?));
  }
}

@JsonSerializable()
class AuthRule {
  final List<dynamic?>? and;

  final List<dynamic?>? or;

  final dynamic? not;

  final String? rule;

  @JsonKey(ignore: true)
  _$AuthRuleCopyWith<AuthRule> get copyWith =>
      __$AuthRuleCopyWithImpl<AuthRule>(this, IdentityFn);

  const AuthRule({this.and, this.or, this.not, this.rule});

  factory AuthRule.fromJson(Map<String, dynamic> json) =>
      _$AuthRuleFromJson(json);

  Map<String, dynamic> toJson() => _$AuthRuleToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is AuthRule &&
        o.and == and &&
        o.or == or &&
        o.not == not &&
        o.rule == rule;
  }

  @override
  int get hashCode => and.hashCode ^ or.hashCode ^ not.hashCode ^ rule.hashCode;

  @override
  String toString() =>
      "AuthRule(and: ${this.and}, or: ${this.or}, not: ${this.not}, rule: ${this.rule})";
}

abstract class $AuthRuleCopyWith<O> {
  factory $AuthRuleCopyWith(AuthRule value, O Function(AuthRule) then) =
      _$AuthRuleCopyWithImpl<O>;
  O call({List<dynamic?>? and, List<dynamic?>? or, dynamic? not, String? rule});
}

class _$AuthRuleCopyWithImpl<O> implements $AuthRuleCopyWith<O> {
  final AuthRule _value;
  final O Function(AuthRule) _then;
  _$AuthRuleCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? and = dimmutable,
      Object? or = dimmutable,
      Object? not = dimmutable,
      Object? rule = dimmutable}) {
    return _then(_value.copyWith(
        and: and == dimmutable ? _value.and : and as List<dynamic?>?,
        or: or == dimmutable ? _value.or : or as List<dynamic?>?,
        not: not == dimmutable ? _value.not : not as dynamic?,
        rule: rule == dimmutable ? _value.rule : rule as String?));
  }
}

abstract class _$AuthRuleCopyWith<O> implements $AuthRuleCopyWith<O> {
  factory _$AuthRuleCopyWith(AuthRule value, O Function(AuthRule) then) =
      __$AuthRuleCopyWithImpl<O>;
  O call({List<dynamic?>? and, List<dynamic?>? or, dynamic? not, String? rule});
}

class __$AuthRuleCopyWithImpl<O> extends _$AuthRuleCopyWithImpl<O>
    implements _$AuthRuleCopyWith<O> {
  __$AuthRuleCopyWithImpl(AuthRule _value, O Function(AuthRule) _then)
      : super(_value, (v) => _then(v));

  @override
  AuthRule get _value => super._value;

  @override
  O call(
      {Object? and = dimmutable,
      Object? or = dimmutable,
      Object? not = dimmutable,
      Object? rule = dimmutable}) {
    return _then(AuthRule(
        and: and == dimmutable ? _value.and : and as List<dynamic?>?,
        or: or == dimmutable ? _value.or : or as List<dynamic?>?,
        not: not == dimmutable ? _value.not : not as dynamic?,
        rule: rule == dimmutable ? _value.rule : rule as String?));
  }
}

@JsonSerializable()
class GenerateMutationParams {
  final bool? add;

  final bool? update;

  final bool? delete;

  @JsonKey(ignore: true)
  _$GenerateMutationParamsCopyWith<GenerateMutationParams> get copyWith =>
      __$GenerateMutationParamsCopyWithImpl<GenerateMutationParams>(
          this, IdentityFn);

  const GenerateMutationParams({this.add, this.update, this.delete});

  factory GenerateMutationParams.fromJson(Map<String, dynamic> json) =>
      _$GenerateMutationParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GenerateMutationParamsToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is GenerateMutationParams &&
        o.add == add &&
        o.update == update &&
        o.delete == delete;
  }

  @override
  int get hashCode => add.hashCode ^ update.hashCode ^ delete.hashCode;

  @override
  String toString() =>
      "GenerateMutationParams(add: ${this.add}, update: ${this.update}, delete: ${this.delete})";
}

abstract class $GenerateMutationParamsCopyWith<O> {
  factory $GenerateMutationParamsCopyWith(GenerateMutationParams value,
          O Function(GenerateMutationParams) then) =
      _$GenerateMutationParamsCopyWithImpl<O>;
  O call({bool? add, bool? update, bool? delete});
}

class _$GenerateMutationParamsCopyWithImpl<O>
    implements $GenerateMutationParamsCopyWith<O> {
  final GenerateMutationParams _value;
  final O Function(GenerateMutationParams) _then;
  _$GenerateMutationParamsCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? add = dimmutable,
      Object? update = dimmutable,
      Object? delete = dimmutable}) {
    return _then(_value.copyWith(
        add: add == dimmutable ? _value.add : add as bool?,
        update: update == dimmutable ? _value.update : update as bool?,
        delete: delete == dimmutable ? _value.delete : delete as bool?));
  }
}

abstract class _$GenerateMutationParamsCopyWith<O>
    implements $GenerateMutationParamsCopyWith<O> {
  factory _$GenerateMutationParamsCopyWith(GenerateMutationParams value,
          O Function(GenerateMutationParams) then) =
      __$GenerateMutationParamsCopyWithImpl<O>;
  O call({bool? add, bool? update, bool? delete});
}

class __$GenerateMutationParamsCopyWithImpl<O>
    extends _$GenerateMutationParamsCopyWithImpl<O>
    implements _$GenerateMutationParamsCopyWith<O> {
  __$GenerateMutationParamsCopyWithImpl(
      GenerateMutationParams _value, O Function(GenerateMutationParams) _then)
      : super(_value, (v) => _then(v));

  @override
  GenerateMutationParams get _value => super._value;

  @override
  O call(
      {Object? add = dimmutable,
      Object? update = dimmutable,
      Object? delete = dimmutable}) {
    return _then(GenerateMutationParams(
        add: add == dimmutable ? _value.add : add as bool?,
        update: update == dimmutable ? _value.update : update as bool?,
        delete: delete == dimmutable ? _value.delete : delete as bool?));
  }
}

@JsonSerializable()
class IntFilter {
  final int? eq;

  final int? le;

  final int? lt;

  final int? ge;

  final int? gt;

  final dynamic? between;

  @JsonKey(ignore: true)
  _$IntFilterCopyWith<IntFilter> get copyWith =>
      __$IntFilterCopyWithImpl<IntFilter>(this, IdentityFn);

  const IntFilter({this.eq, this.le, this.lt, this.ge, this.gt, this.between});

  factory IntFilter.fromJson(Map<String, dynamic> json) =>
      _$IntFilterFromJson(json);

  Map<String, dynamic> toJson() => _$IntFilterToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is IntFilter &&
        o.eq == eq &&
        o.le == le &&
        o.lt == lt &&
        o.ge == ge &&
        o.gt == gt &&
        o.between == between;
  }

  @override
  int get hashCode =>
      eq.hashCode ^
      le.hashCode ^
      lt.hashCode ^
      ge.hashCode ^
      gt.hashCode ^
      between.hashCode;

  @override
  String toString() =>
      "IntFilter(eq: ${this.eq}, le: ${this.le}, lt: ${this.lt}, ge: ${this.ge}, gt: ${this.gt}, between: ${this.between})";
}

abstract class $IntFilterCopyWith<O> {
  factory $IntFilterCopyWith(IntFilter value, O Function(IntFilter) then) =
      _$IntFilterCopyWithImpl<O>;
  O call({int? eq, int? le, int? lt, int? ge, int? gt, dynamic? between});
}

class _$IntFilterCopyWithImpl<O> implements $IntFilterCopyWith<O> {
  final IntFilter _value;
  final O Function(IntFilter) _then;
  _$IntFilterCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? eq = dimmutable,
      Object? le = dimmutable,
      Object? lt = dimmutable,
      Object? ge = dimmutable,
      Object? gt = dimmutable,
      Object? between = dimmutable}) {
    return _then(_value.copyWith(
        eq: eq == dimmutable ? _value.eq : eq as int?,
        le: le == dimmutable ? _value.le : le as int?,
        lt: lt == dimmutable ? _value.lt : lt as int?,
        ge: ge == dimmutable ? _value.ge : ge as int?,
        gt: gt == dimmutable ? _value.gt : gt as int?,
        between: between == dimmutable ? _value.between : between as dynamic?));
  }
}

abstract class _$IntFilterCopyWith<O> implements $IntFilterCopyWith<O> {
  factory _$IntFilterCopyWith(IntFilter value, O Function(IntFilter) then) =
      __$IntFilterCopyWithImpl<O>;
  O call({int? eq, int? le, int? lt, int? ge, int? gt, dynamic? between});
}

class __$IntFilterCopyWithImpl<O> extends _$IntFilterCopyWithImpl<O>
    implements _$IntFilterCopyWith<O> {
  __$IntFilterCopyWithImpl(IntFilter _value, O Function(IntFilter) _then)
      : super(_value, (v) => _then(v));

  @override
  IntFilter get _value => super._value;

  @override
  O call(
      {Object? eq = dimmutable,
      Object? le = dimmutable,
      Object? lt = dimmutable,
      Object? ge = dimmutable,
      Object? gt = dimmutable,
      Object? between = dimmutable}) {
    return _then(IntFilter(
        eq: eq == dimmutable ? _value.eq : eq as int?,
        le: le == dimmutable ? _value.le : le as int?,
        lt: lt == dimmutable ? _value.lt : lt as int?,
        ge: ge == dimmutable ? _value.ge : ge as int?,
        gt: gt == dimmutable ? _value.gt : gt as int?,
        between: between == dimmutable ? _value.between : between as dynamic?));
  }
}

@JsonSerializable()
class UserFilter {
  final dynamic? username;

  final dynamic? has;

  final List<dynamic?>? and;

  final List<dynamic?>? or;

  final dynamic? not;

  @JsonKey(ignore: true)
  _$UserFilterCopyWith<UserFilter> get copyWith =>
      __$UserFilterCopyWithImpl<UserFilter>(this, IdentityFn);

  const UserFilter({this.username, this.has, this.and, this.or, this.not});

  factory UserFilter.fromJson(Map<String, dynamic> json) =>
      _$UserFilterFromJson(json);

  Map<String, dynamic> toJson() => _$UserFilterToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is UserFilter &&
        o.username == username &&
        o.has == has &&
        o.and == and &&
        o.or == or &&
        o.not == not;
  }

  @override
  int get hashCode =>
      username.hashCode ^
      has.hashCode ^
      and.hashCode ^
      or.hashCode ^
      not.hashCode;

  @override
  String toString() =>
      "UserFilter(username: ${this.username}, has: ${this.has}, and: ${this.and}, or: ${this.or}, not: ${this.not})";
}

abstract class $UserFilterCopyWith<O> {
  factory $UserFilterCopyWith(UserFilter value, O Function(UserFilter) then) =
      _$UserFilterCopyWithImpl<O>;
  O call(
      {dynamic? username,
      dynamic? has,
      List<dynamic?>? and,
      List<dynamic?>? or,
      dynamic? not});
}

class _$UserFilterCopyWithImpl<O> implements $UserFilterCopyWith<O> {
  final UserFilter _value;
  final O Function(UserFilter) _then;
  _$UserFilterCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? username = dimmutable,
      Object? has = dimmutable,
      Object? and = dimmutable,
      Object? or = dimmutable,
      Object? not = dimmutable}) {
    return _then(_value.copyWith(
        username:
            username == dimmutable ? _value.username : username as dynamic?,
        has: has == dimmutable ? _value.has : has as dynamic?,
        and: and == dimmutable ? _value.and : and as List<dynamic?>?,
        or: or == dimmutable ? _value.or : or as List<dynamic?>?,
        not: not == dimmutable ? _value.not : not as dynamic?));
  }
}

abstract class _$UserFilterCopyWith<O> implements $UserFilterCopyWith<O> {
  factory _$UserFilterCopyWith(UserFilter value, O Function(UserFilter) then) =
      __$UserFilterCopyWithImpl<O>;
  O call(
      {dynamic? username,
      dynamic? has,
      List<dynamic?>? and,
      List<dynamic?>? or,
      dynamic? not});
}

class __$UserFilterCopyWithImpl<O> extends _$UserFilterCopyWithImpl<O>
    implements _$UserFilterCopyWith<O> {
  __$UserFilterCopyWithImpl(UserFilter _value, O Function(UserFilter) _then)
      : super(_value, (v) => _then(v));

  @override
  UserFilter get _value => super._value;

  @override
  O call(
      {Object? username = dimmutable,
      Object? has = dimmutable,
      Object? and = dimmutable,
      Object? or = dimmutable,
      Object? not = dimmutable}) {
    return _then(UserFilter(
        username:
            username == dimmutable ? _value.username : username as dynamic?,
        has: has == dimmutable ? _value.has : has as dynamic?,
        and: and == dimmutable ? _value.and : and as List<dynamic?>?,
        or: or == dimmutable ? _value.or : or as List<dynamic?>?,
        not: not == dimmutable ? _value.not : not as dynamic?));
  }
}

@JsonSerializable()
class IntRange {
  final int min;

  final int max;

  @JsonKey(ignore: true)
  _$IntRangeCopyWith<IntRange> get copyWith =>
      __$IntRangeCopyWithImpl<IntRange>(this, IdentityFn);

  const IntRange({required this.min, required this.max});

  factory IntRange.fromJson(Map<String, dynamic> json) =>
      _$IntRangeFromJson(json);

  Map<String, dynamic> toJson() => _$IntRangeToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is IntRange && o.min == min && o.max == max;
  }

  @override
  int get hashCode => min.hashCode ^ max.hashCode;

  @override
  String toString() => "IntRange(min: ${this.min}, max: ${this.max})";
}

abstract class $IntRangeCopyWith<O> {
  factory $IntRangeCopyWith(IntRange value, O Function(IntRange) then) =
      _$IntRangeCopyWithImpl<O>;
  O call({int min, int max});
}

class _$IntRangeCopyWithImpl<O> implements $IntRangeCopyWith<O> {
  final IntRange _value;
  final O Function(IntRange) _then;
  _$IntRangeCopyWithImpl(this._value, this._then);

  @override
  O call({Object? min = dimmutable, Object? max = dimmutable}) {
    return _then(_value.copyWith(
        min: min == dimmutable ? _value.min : min as int,
        max: max == dimmutable ? _value.max : max as int));
  }
}

abstract class _$IntRangeCopyWith<O> implements $IntRangeCopyWith<O> {
  factory _$IntRangeCopyWith(IntRange value, O Function(IntRange) then) =
      __$IntRangeCopyWithImpl<O>;
  O call({int min, int max});
}

class __$IntRangeCopyWithImpl<O> extends _$IntRangeCopyWithImpl<O>
    implements _$IntRangeCopyWith<O> {
  __$IntRangeCopyWithImpl(IntRange _value, O Function(IntRange) _then)
      : super(_value, (v) => _then(v));

  @override
  IntRange get _value => super._value;

  @override
  O call({Object? min = dimmutable, Object? max = dimmutable}) {
    return _then(IntRange(
        min: min == dimmutable ? _value.min : min as int,
        max: max == dimmutable ? _value.max : max as int));
  }
}

@JsonSerializable()
class AuthorPatch {
  final String? name;

  final List<dynamic>? posts;

  final List<dynamic?>? friends;

  final int? n;

  @JsonKey(ignore: true)
  _$AuthorPatchCopyWith<AuthorPatch> get copyWith =>
      __$AuthorPatchCopyWithImpl<AuthorPatch>(this, IdentityFn);

  const AuthorPatch({this.name, this.posts, this.friends, this.n});

  factory AuthorPatch.fromJson(Map<String, dynamic> json) =>
      _$AuthorPatchFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorPatchToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is AuthorPatch &&
        o.name == name &&
        o.posts == posts &&
        o.friends == friends &&
        o.n == n;
  }

  @override
  int get hashCode =>
      name.hashCode ^ posts.hashCode ^ friends.hashCode ^ n.hashCode;

  @override
  String toString() =>
      "AuthorPatch(name: ${this.name}, posts: ${this.posts}, friends: ${this.friends}, n: ${this.n})";
}

abstract class $AuthorPatchCopyWith<O> {
  factory $AuthorPatchCopyWith(
          AuthorPatch value, O Function(AuthorPatch) then) =
      _$AuthorPatchCopyWithImpl<O>;
  O call({String? name, List<dynamic>? posts, List<dynamic?>? friends, int? n});
}

class _$AuthorPatchCopyWithImpl<O> implements $AuthorPatchCopyWith<O> {
  final AuthorPatch _value;
  final O Function(AuthorPatch) _then;
  _$AuthorPatchCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? name = dimmutable,
      Object? posts = dimmutable,
      Object? friends = dimmutable,
      Object? n = dimmutable}) {
    return _then(_value.copyWith(
        name: name == dimmutable ? _value.name : name as String?,
        posts: posts == dimmutable ? _value.posts : posts as List<dynamic>?,
        friends:
            friends == dimmutable ? _value.friends : friends as List<dynamic?>?,
        n: n == dimmutable ? _value.n : n as int?));
  }
}

abstract class _$AuthorPatchCopyWith<O> implements $AuthorPatchCopyWith<O> {
  factory _$AuthorPatchCopyWith(
          AuthorPatch value, O Function(AuthorPatch) then) =
      __$AuthorPatchCopyWithImpl<O>;
  O call({String? name, List<dynamic>? posts, List<dynamic?>? friends, int? n});
}

class __$AuthorPatchCopyWithImpl<O> extends _$AuthorPatchCopyWithImpl<O>
    implements _$AuthorPatchCopyWith<O> {
  __$AuthorPatchCopyWithImpl(AuthorPatch _value, O Function(AuthorPatch) _then)
      : super(_value, (v) => _then(v));

  @override
  AuthorPatch get _value => super._value;

  @override
  O call(
      {Object? name = dimmutable,
      Object? posts = dimmutable,
      Object? friends = dimmutable,
      Object? n = dimmutable}) {
    return _then(AuthorPatch(
        name: name == dimmutable ? _value.name : name as String?,
        posts: posts == dimmutable ? _value.posts : posts as List<dynamic>?,
        friends:
            friends == dimmutable ? _value.friends : friends as List<dynamic?>?,
        n: n == dimmutable ? _value.n : n as int?));
  }
}

@JsonSerializable()
class AuthorRef {
  final String? id;

  final String? name;

  final List<dynamic>? posts;

  final List<dynamic?>? friends;

  final int? n;

  @JsonKey(ignore: true)
  _$AuthorRefCopyWith<AuthorRef> get copyWith =>
      __$AuthorRefCopyWithImpl<AuthorRef>(this, IdentityFn);

  const AuthorRef({this.id, this.name, this.posts, this.friends, this.n});

  factory AuthorRef.fromJson(Map<String, dynamic> json) =>
      _$AuthorRefFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorRefToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is AuthorRef &&
        o.id == id &&
        o.name == name &&
        o.posts == posts &&
        o.friends == friends &&
        o.n == n;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      posts.hashCode ^
      friends.hashCode ^
      n.hashCode;

  @override
  String toString() =>
      "AuthorRef(id: ${this.id}, name: ${this.name}, posts: ${this.posts}, friends: ${this.friends}, n: ${this.n})";
}

abstract class $AuthorRefCopyWith<O> {
  factory $AuthorRefCopyWith(AuthorRef value, O Function(AuthorRef) then) =
      _$AuthorRefCopyWithImpl<O>;
  O call(
      {String? id,
      String? name,
      List<dynamic>? posts,
      List<dynamic?>? friends,
      int? n});
}

class _$AuthorRefCopyWithImpl<O> implements $AuthorRefCopyWith<O> {
  final AuthorRef _value;
  final O Function(AuthorRef) _then;
  _$AuthorRefCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? id = dimmutable,
      Object? name = dimmutable,
      Object? posts = dimmutable,
      Object? friends = dimmutable,
      Object? n = dimmutable}) {
    return _then(_value.copyWith(
        id: id == dimmutable ? _value.id : id as String?,
        name: name == dimmutable ? _value.name : name as String?,
        posts: posts == dimmutable ? _value.posts : posts as List<dynamic>?,
        friends:
            friends == dimmutable ? _value.friends : friends as List<dynamic?>?,
        n: n == dimmutable ? _value.n : n as int?));
  }
}

abstract class _$AuthorRefCopyWith<O> implements $AuthorRefCopyWith<O> {
  factory _$AuthorRefCopyWith(AuthorRef value, O Function(AuthorRef) then) =
      __$AuthorRefCopyWithImpl<O>;
  O call(
      {String? id,
      String? name,
      List<dynamic>? posts,
      List<dynamic?>? friends,
      int? n});
}

class __$AuthorRefCopyWithImpl<O> extends _$AuthorRefCopyWithImpl<O>
    implements _$AuthorRefCopyWith<O> {
  __$AuthorRefCopyWithImpl(AuthorRef _value, O Function(AuthorRef) _then)
      : super(_value, (v) => _then(v));

  @override
  AuthorRef get _value => super._value;

  @override
  O call(
      {Object? id = dimmutable,
      Object? name = dimmutable,
      Object? posts = dimmutable,
      Object? friends = dimmutable,
      Object? n = dimmutable}) {
    return _then(AuthorRef(
        id: id == dimmutable ? _value.id : id as String?,
        name: name == dimmutable ? _value.name : name as String?,
        posts: posts == dimmutable ? _value.posts : posts as List<dynamic>?,
        friends:
            friends == dimmutable ? _value.friends : friends as List<dynamic?>?,
        n: n == dimmutable ? _value.n : n as int?));
  }
}

@JsonSerializable()
class PostOrder {
  final dynamic? asc;

  final dynamic? desc;

  final dynamic? then;

  @JsonKey(ignore: true)
  _$PostOrderCopyWith<PostOrder> get copyWith =>
      __$PostOrderCopyWithImpl<PostOrder>(this, IdentityFn);

  const PostOrder({this.asc, this.desc, this.then});

  factory PostOrder.fromJson(Map<String, dynamic> json) =>
      _$PostOrderFromJson(json);

  Map<String, dynamic> toJson() => _$PostOrderToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is PostOrder && o.asc == asc && o.desc == desc && o.then == then;
  }

  @override
  int get hashCode => asc.hashCode ^ desc.hashCode ^ then.hashCode;

  @override
  String toString() =>
      "PostOrder(asc: ${this.asc}, desc: ${this.desc}, then: ${this.then})";
}

abstract class $PostOrderCopyWith<O> {
  factory $PostOrderCopyWith(PostOrder value, O Function(PostOrder) then) =
      _$PostOrderCopyWithImpl<O>;
  O call({dynamic? asc, dynamic? desc, dynamic? then});
}

class _$PostOrderCopyWithImpl<O> implements $PostOrderCopyWith<O> {
  final PostOrder _value;
  final O Function(PostOrder) _then;
  _$PostOrderCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? asc = dimmutable,
      Object? desc = dimmutable,
      Object? then = dimmutable}) {
    return _then(_value.copyWith(
        asc: asc == dimmutable ? _value.asc : asc as dynamic?,
        desc: desc == dimmutable ? _value.desc : desc as dynamic?,
        then: then == dimmutable ? _value.then : then as dynamic?));
  }
}

abstract class _$PostOrderCopyWith<O> implements $PostOrderCopyWith<O> {
  factory _$PostOrderCopyWith(PostOrder value, O Function(PostOrder) then) =
      __$PostOrderCopyWithImpl<O>;
  O call({dynamic? asc, dynamic? desc, dynamic? then});
}

class __$PostOrderCopyWithImpl<O> extends _$PostOrderCopyWithImpl<O>
    implements _$PostOrderCopyWith<O> {
  __$PostOrderCopyWithImpl(PostOrder _value, O Function(PostOrder) _then)
      : super(_value, (v) => _then(v));

  @override
  PostOrder get _value => super._value;

  @override
  O call(
      {Object? asc = dimmutable,
      Object? desc = dimmutable,
      Object? then = dimmutable}) {
    return _then(PostOrder(
        asc: asc == dimmutable ? _value.asc : asc as dynamic?,
        desc: desc == dimmutable ? _value.desc : desc as dynamic?,
        then: then == dimmutable ? _value.then : then as dynamic?));
  }
}

@JsonSerializable()
class NearFilter {
  final double distance;

  final dynamic coordinate;

  @JsonKey(ignore: true)
  _$NearFilterCopyWith<NearFilter> get copyWith =>
      __$NearFilterCopyWithImpl<NearFilter>(this, IdentityFn);

  const NearFilter({required this.distance, required this.coordinate});

  factory NearFilter.fromJson(Map<String, dynamic> json) =>
      _$NearFilterFromJson(json);

  Map<String, dynamic> toJson() => _$NearFilterToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is NearFilter &&
        o.distance == distance &&
        o.coordinate == coordinate;
  }

  @override
  int get hashCode => distance.hashCode ^ coordinate.hashCode;

  @override
  String toString() =>
      "NearFilter(distance: ${this.distance}, coordinate: ${this.coordinate})";
}

abstract class $NearFilterCopyWith<O> {
  factory $NearFilterCopyWith(NearFilter value, O Function(NearFilter) then) =
      _$NearFilterCopyWithImpl<O>;
  O call({double distance, dynamic coordinate});
}

class _$NearFilterCopyWithImpl<O> implements $NearFilterCopyWith<O> {
  final NearFilter _value;
  final O Function(NearFilter) _then;
  _$NearFilterCopyWithImpl(this._value, this._then);

  @override
  O call({Object? distance = dimmutable, Object? coordinate = dimmutable}) {
    return _then(_value.copyWith(
        distance: distance == dimmutable ? _value.distance : distance as double,
        coordinate: coordinate == dimmutable
            ? _value.coordinate
            : coordinate as dynamic));
  }
}

abstract class _$NearFilterCopyWith<O> implements $NearFilterCopyWith<O> {
  factory _$NearFilterCopyWith(NearFilter value, O Function(NearFilter) then) =
      __$NearFilterCopyWithImpl<O>;
  O call({double distance, dynamic coordinate});
}

class __$NearFilterCopyWithImpl<O> extends _$NearFilterCopyWithImpl<O>
    implements _$NearFilterCopyWith<O> {
  __$NearFilterCopyWithImpl(NearFilter _value, O Function(NearFilter) _then)
      : super(_value, (v) => _then(v));

  @override
  NearFilter get _value => super._value;

  @override
  O call({Object? distance = dimmutable, Object? coordinate = dimmutable}) {
    return _then(NearFilter(
        distance: distance == dimmutable ? _value.distance : distance as double,
        coordinate: coordinate == dimmutable
            ? _value.coordinate
            : coordinate as dynamic));
  }
}

@JsonSerializable()
class ContainsFilter {
  final dynamic? point;

  final dynamic? polygon;

  @JsonKey(ignore: true)
  _$ContainsFilterCopyWith<ContainsFilter> get copyWith =>
      __$ContainsFilterCopyWithImpl<ContainsFilter>(this, IdentityFn);

  const ContainsFilter({this.point, this.polygon});

  factory ContainsFilter.fromJson(Map<String, dynamic> json) =>
      _$ContainsFilterFromJson(json);

  Map<String, dynamic> toJson() => _$ContainsFilterToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is ContainsFilter && o.point == point && o.polygon == polygon;
  }

  @override
  int get hashCode => point.hashCode ^ polygon.hashCode;

  @override
  String toString() =>
      "ContainsFilter(point: ${this.point}, polygon: ${this.polygon})";
}

abstract class $ContainsFilterCopyWith<O> {
  factory $ContainsFilterCopyWith(
          ContainsFilter value, O Function(ContainsFilter) then) =
      _$ContainsFilterCopyWithImpl<O>;
  O call({dynamic? point, dynamic? polygon});
}

class _$ContainsFilterCopyWithImpl<O> implements $ContainsFilterCopyWith<O> {
  final ContainsFilter _value;
  final O Function(ContainsFilter) _then;
  _$ContainsFilterCopyWithImpl(this._value, this._then);

  @override
  O call({Object? point = dimmutable, Object? polygon = dimmutable}) {
    return _then(_value.copyWith(
        point: point == dimmutable ? _value.point : point as dynamic?,
        polygon: polygon == dimmutable ? _value.polygon : polygon as dynamic?));
  }
}

abstract class _$ContainsFilterCopyWith<O>
    implements $ContainsFilterCopyWith<O> {
  factory _$ContainsFilterCopyWith(
          ContainsFilter value, O Function(ContainsFilter) then) =
      __$ContainsFilterCopyWithImpl<O>;
  O call({dynamic? point, dynamic? polygon});
}

class __$ContainsFilterCopyWithImpl<O> extends _$ContainsFilterCopyWithImpl<O>
    implements _$ContainsFilterCopyWith<O> {
  __$ContainsFilterCopyWithImpl(
      ContainsFilter _value, O Function(ContainsFilter) _then)
      : super(_value, (v) => _then(v));

  @override
  ContainsFilter get _value => super._value;

  @override
  O call({Object? point = dimmutable, Object? polygon = dimmutable}) {
    return _then(ContainsFilter(
        point: point == dimmutable ? _value.point : point as dynamic?,
        polygon: polygon == dimmutable ? _value.polygon : polygon as dynamic?));
  }
}

@JsonSerializable()
class UpdatePostInput {
  final dynamic filter;

  final dynamic? set;

  final dynamic? remove;

  @JsonKey(ignore: true)
  _$UpdatePostInputCopyWith<UpdatePostInput> get copyWith =>
      __$UpdatePostInputCopyWithImpl<UpdatePostInput>(this, IdentityFn);

  const UpdatePostInput({required this.filter, this.set, this.remove});

  factory UpdatePostInput.fromJson(Map<String, dynamic> json) =>
      _$UpdatePostInputFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePostInputToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is UpdatePostInput &&
        o.filter == filter &&
        o.set == set &&
        o.remove == remove;
  }

  @override
  int get hashCode => filter.hashCode ^ set.hashCode ^ remove.hashCode;

  @override
  String toString() =>
      "UpdatePostInput(filter: ${this.filter}, set: ${this.set}, remove: ${this.remove})";
}

abstract class $UpdatePostInputCopyWith<O> {
  factory $UpdatePostInputCopyWith(
          UpdatePostInput value, O Function(UpdatePostInput) then) =
      _$UpdatePostInputCopyWithImpl<O>;
  O call({dynamic filter, dynamic? set, dynamic? remove});
}

class _$UpdatePostInputCopyWithImpl<O> implements $UpdatePostInputCopyWith<O> {
  final UpdatePostInput _value;
  final O Function(UpdatePostInput) _then;
  _$UpdatePostInputCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? filter = dimmutable,
      Object? set = dimmutable,
      Object? remove = dimmutable}) {
    return _then(_value.copyWith(
        filter: filter == dimmutable ? _value.filter : filter as dynamic,
        set: set == dimmutable ? _value.set : set as dynamic?,
        remove: remove == dimmutable ? _value.remove : remove as dynamic?));
  }
}

abstract class _$UpdatePostInputCopyWith<O>
    implements $UpdatePostInputCopyWith<O> {
  factory _$UpdatePostInputCopyWith(
          UpdatePostInput value, O Function(UpdatePostInput) then) =
      __$UpdatePostInputCopyWithImpl<O>;
  O call({dynamic filter, dynamic? set, dynamic? remove});
}

class __$UpdatePostInputCopyWithImpl<O> extends _$UpdatePostInputCopyWithImpl<O>
    implements _$UpdatePostInputCopyWith<O> {
  __$UpdatePostInputCopyWithImpl(
      UpdatePostInput _value, O Function(UpdatePostInput) _then)
      : super(_value, (v) => _then(v));

  @override
  UpdatePostInput get _value => super._value;

  @override
  O call(
      {Object? filter = dimmutable,
      Object? set = dimmutable,
      Object? remove = dimmutable}) {
    return _then(UpdatePostInput(
        filter: filter == dimmutable ? _value.filter : filter as dynamic,
        set: set == dimmutable ? _value.set : set as dynamic?,
        remove: remove == dimmutable ? _value.remove : remove as dynamic?));
  }
}

@JsonSerializable()
class PointGeoFilter {
  final dynamic? near;

  final dynamic? within;

  @JsonKey(ignore: true)
  _$PointGeoFilterCopyWith<PointGeoFilter> get copyWith =>
      __$PointGeoFilterCopyWithImpl<PointGeoFilter>(this, IdentityFn);

  const PointGeoFilter({this.near, this.within});

  factory PointGeoFilter.fromJson(Map<String, dynamic> json) =>
      _$PointGeoFilterFromJson(json);

  Map<String, dynamic> toJson() => _$PointGeoFilterToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is PointGeoFilter && o.near == near && o.within == within;
  }

  @override
  int get hashCode => near.hashCode ^ within.hashCode;

  @override
  String toString() =>
      "PointGeoFilter(near: ${this.near}, within: ${this.within})";
}

abstract class $PointGeoFilterCopyWith<O> {
  factory $PointGeoFilterCopyWith(
          PointGeoFilter value, O Function(PointGeoFilter) then) =
      _$PointGeoFilterCopyWithImpl<O>;
  O call({dynamic? near, dynamic? within});
}

class _$PointGeoFilterCopyWithImpl<O> implements $PointGeoFilterCopyWith<O> {
  final PointGeoFilter _value;
  final O Function(PointGeoFilter) _then;
  _$PointGeoFilterCopyWithImpl(this._value, this._then);

  @override
  O call({Object? near = dimmutable, Object? within = dimmutable}) {
    return _then(_value.copyWith(
        near: near == dimmutable ? _value.near : near as dynamic?,
        within: within == dimmutable ? _value.within : within as dynamic?));
  }
}

abstract class _$PointGeoFilterCopyWith<O>
    implements $PointGeoFilterCopyWith<O> {
  factory _$PointGeoFilterCopyWith(
          PointGeoFilter value, O Function(PointGeoFilter) then) =
      __$PointGeoFilterCopyWithImpl<O>;
  O call({dynamic? near, dynamic? within});
}

class __$PointGeoFilterCopyWithImpl<O> extends _$PointGeoFilterCopyWithImpl<O>
    implements _$PointGeoFilterCopyWith<O> {
  __$PointGeoFilterCopyWithImpl(
      PointGeoFilter _value, O Function(PointGeoFilter) _then)
      : super(_value, (v) => _then(v));

  @override
  PointGeoFilter get _value => super._value;

  @override
  O call({Object? near = dimmutable, Object? within = dimmutable}) {
    return _then(PointGeoFilter(
        near: near == dimmutable ? _value.near : near as dynamic?,
        within: within == dimmutable ? _value.within : within as dynamic?));
  }
}

@JsonSerializable()
class UserPatch {
  final String? name;

  final List<dynamic?>? tasks;

  @JsonKey(ignore: true)
  _$UserPatchCopyWith<UserPatch> get copyWith =>
      __$UserPatchCopyWithImpl<UserPatch>(this, IdentityFn);

  const UserPatch({this.name, this.tasks});

  factory UserPatch.fromJson(Map<String, dynamic> json) =>
      _$UserPatchFromJson(json);

  Map<String, dynamic> toJson() => _$UserPatchToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is UserPatch && o.name == name && o.tasks == tasks;
  }

  @override
  int get hashCode => name.hashCode ^ tasks.hashCode;

  @override
  String toString() => "UserPatch(name: ${this.name}, tasks: ${this.tasks})";
}

abstract class $UserPatchCopyWith<O> {
  factory $UserPatchCopyWith(UserPatch value, O Function(UserPatch) then) =
      _$UserPatchCopyWithImpl<O>;
  O call({String? name, List<dynamic?>? tasks});
}

class _$UserPatchCopyWithImpl<O> implements $UserPatchCopyWith<O> {
  final UserPatch _value;
  final O Function(UserPatch) _then;
  _$UserPatchCopyWithImpl(this._value, this._then);

  @override
  O call({Object? name = dimmutable, Object? tasks = dimmutable}) {
    return _then(_value.copyWith(
        name: name == dimmutable ? _value.name : name as String?,
        tasks: tasks == dimmutable ? _value.tasks : tasks as List<dynamic?>?));
  }
}

abstract class _$UserPatchCopyWith<O> implements $UserPatchCopyWith<O> {
  factory _$UserPatchCopyWith(UserPatch value, O Function(UserPatch) then) =
      __$UserPatchCopyWithImpl<O>;
  O call({String? name, List<dynamic?>? tasks});
}

class __$UserPatchCopyWithImpl<O> extends _$UserPatchCopyWithImpl<O>
    implements _$UserPatchCopyWith<O> {
  __$UserPatchCopyWithImpl(UserPatch _value, O Function(UserPatch) _then)
      : super(_value, (v) => _then(v));

  @override
  UserPatch get _value => super._value;

  @override
  O call({Object? name = dimmutable, Object? tasks = dimmutable}) {
    return _then(UserPatch(
        name: name == dimmutable ? _value.name : name as String?,
        tasks: tasks == dimmutable ? _value.tasks : tasks as List<dynamic?>?));
  }
}

@JsonSerializable()
class Int64Range {
  final int min;

  final int max;

  @JsonKey(ignore: true)
  _$Int64RangeCopyWith<Int64Range> get copyWith =>
      __$Int64RangeCopyWithImpl<Int64Range>(this, IdentityFn);

  const Int64Range({required this.min, required this.max});

  factory Int64Range.fromJson(Map<String, dynamic> json) =>
      _$Int64RangeFromJson(json);

  Map<String, dynamic> toJson() => _$Int64RangeToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is Int64Range && o.min == min && o.max == max;
  }

  @override
  int get hashCode => min.hashCode ^ max.hashCode;

  @override
  String toString() => "Int64Range(min: ${this.min}, max: ${this.max})";
}

abstract class $Int64RangeCopyWith<O> {
  factory $Int64RangeCopyWith(Int64Range value, O Function(Int64Range) then) =
      _$Int64RangeCopyWithImpl<O>;
  O call({int min, int max});
}

class _$Int64RangeCopyWithImpl<O> implements $Int64RangeCopyWith<O> {
  final Int64Range _value;
  final O Function(Int64Range) _then;
  _$Int64RangeCopyWithImpl(this._value, this._then);

  @override
  O call({Object? min = dimmutable, Object? max = dimmutable}) {
    return _then(_value.copyWith(
        min: min == dimmutable ? _value.min : min as int,
        max: max == dimmutable ? _value.max : max as int));
  }
}

abstract class _$Int64RangeCopyWith<O> implements $Int64RangeCopyWith<O> {
  factory _$Int64RangeCopyWith(Int64Range value, O Function(Int64Range) then) =
      __$Int64RangeCopyWithImpl<O>;
  O call({int min, int max});
}

class __$Int64RangeCopyWithImpl<O> extends _$Int64RangeCopyWithImpl<O>
    implements _$Int64RangeCopyWith<O> {
  __$Int64RangeCopyWithImpl(Int64Range _value, O Function(Int64Range) _then)
      : super(_value, (v) => _then(v));

  @override
  Int64Range get _value => super._value;

  @override
  O call({Object? min = dimmutable, Object? max = dimmutable}) {
    return _then(Int64Range(
        min: min == dimmutable ? _value.min : min as int,
        max: max == dimmutable ? _value.max : max as int));
  }
}

@JsonSerializable()
class PolygonRef {
  final List<dynamic> coordinates;

  @JsonKey(ignore: true)
  _$PolygonRefCopyWith<PolygonRef> get copyWith =>
      __$PolygonRefCopyWithImpl<PolygonRef>(this, IdentityFn);

  const PolygonRef({required this.coordinates});

  factory PolygonRef.fromJson(Map<String, dynamic> json) =>
      _$PolygonRefFromJson(json);

  Map<String, dynamic> toJson() => _$PolygonRefToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is PolygonRef && o.coordinates == coordinates;
  }

  @override
  int get hashCode => coordinates.hashCode;

  @override
  String toString() => "PolygonRef(coordinates: ${this.coordinates})";
}

abstract class $PolygonRefCopyWith<O> {
  factory $PolygonRefCopyWith(PolygonRef value, O Function(PolygonRef) then) =
      _$PolygonRefCopyWithImpl<O>;
  O call({List<dynamic> coordinates});
}

class _$PolygonRefCopyWithImpl<O> implements $PolygonRefCopyWith<O> {
  final PolygonRef _value;
  final O Function(PolygonRef) _then;
  _$PolygonRefCopyWithImpl(this._value, this._then);

  @override
  O call({Object? coordinates = dimmutable}) {
    return _then(_value.copyWith(
        coordinates: coordinates == dimmutable
            ? _value.coordinates
            : coordinates as List<dynamic>));
  }
}

abstract class _$PolygonRefCopyWith<O> implements $PolygonRefCopyWith<O> {
  factory _$PolygonRefCopyWith(PolygonRef value, O Function(PolygonRef) then) =
      __$PolygonRefCopyWithImpl<O>;
  O call({List<dynamic> coordinates});
}

class __$PolygonRefCopyWithImpl<O> extends _$PolygonRefCopyWithImpl<O>
    implements _$PolygonRefCopyWith<O> {
  __$PolygonRefCopyWithImpl(PolygonRef _value, O Function(PolygonRef) _then)
      : super(_value, (v) => _then(v));

  @override
  PolygonRef get _value => super._value;

  @override
  O call({Object? coordinates = dimmutable}) {
    return _then(PolygonRef(
        coordinates: coordinates == dimmutable
            ? _value.coordinates
            : coordinates as List<dynamic>));
  }
}

@JsonSerializable()
class MultiPolygonRef {
  final List<dynamic> polygons;

  @JsonKey(ignore: true)
  _$MultiPolygonRefCopyWith<MultiPolygonRef> get copyWith =>
      __$MultiPolygonRefCopyWithImpl<MultiPolygonRef>(this, IdentityFn);

  const MultiPolygonRef({required this.polygons});

  factory MultiPolygonRef.fromJson(Map<String, dynamic> json) =>
      _$MultiPolygonRefFromJson(json);

  Map<String, dynamic> toJson() => _$MultiPolygonRefToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is MultiPolygonRef && o.polygons == polygons;
  }

  @override
  int get hashCode => polygons.hashCode;

  @override
  String toString() => "MultiPolygonRef(polygons: ${this.polygons})";
}

abstract class $MultiPolygonRefCopyWith<O> {
  factory $MultiPolygonRefCopyWith(
          MultiPolygonRef value, O Function(MultiPolygonRef) then) =
      _$MultiPolygonRefCopyWithImpl<O>;
  O call({List<dynamic> polygons});
}

class _$MultiPolygonRefCopyWithImpl<O> implements $MultiPolygonRefCopyWith<O> {
  final MultiPolygonRef _value;
  final O Function(MultiPolygonRef) _then;
  _$MultiPolygonRefCopyWithImpl(this._value, this._then);

  @override
  O call({Object? polygons = dimmutable}) {
    return _then(_value.copyWith(
        polygons: polygons == dimmutable
            ? _value.polygons
            : polygons as List<dynamic>));
  }
}

abstract class _$MultiPolygonRefCopyWith<O>
    implements $MultiPolygonRefCopyWith<O> {
  factory _$MultiPolygonRefCopyWith(
          MultiPolygonRef value, O Function(MultiPolygonRef) then) =
      __$MultiPolygonRefCopyWithImpl<O>;
  O call({List<dynamic> polygons});
}

class __$MultiPolygonRefCopyWithImpl<O> extends _$MultiPolygonRefCopyWithImpl<O>
    implements _$MultiPolygonRefCopyWith<O> {
  __$MultiPolygonRefCopyWithImpl(
      MultiPolygonRef _value, O Function(MultiPolygonRef) _then)
      : super(_value, (v) => _then(v));

  @override
  MultiPolygonRef get _value => super._value;

  @override
  O call({Object? polygons = dimmutable}) {
    return _then(MultiPolygonRef(
        polygons: polygons == dimmutable
            ? _value.polygons
            : polygons as List<dynamic>));
  }
}

@JsonSerializable()
class StringRange {
  final String min;

  final String max;

  @JsonKey(ignore: true)
  _$StringRangeCopyWith<StringRange> get copyWith =>
      __$StringRangeCopyWithImpl<StringRange>(this, IdentityFn);

  const StringRange({required this.min, required this.max});

  factory StringRange.fromJson(Map<String, dynamic> json) =>
      _$StringRangeFromJson(json);

  Map<String, dynamic> toJson() => _$StringRangeToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is StringRange && o.min == min && o.max == max;
  }

  @override
  int get hashCode => min.hashCode ^ max.hashCode;

  @override
  String toString() => "StringRange(min: ${this.min}, max: ${this.max})";
}

abstract class $StringRangeCopyWith<O> {
  factory $StringRangeCopyWith(
          StringRange value, O Function(StringRange) then) =
      _$StringRangeCopyWithImpl<O>;
  O call({String min, String max});
}

class _$StringRangeCopyWithImpl<O> implements $StringRangeCopyWith<O> {
  final StringRange _value;
  final O Function(StringRange) _then;
  _$StringRangeCopyWithImpl(this._value, this._then);

  @override
  O call({Object? min = dimmutable, Object? max = dimmutable}) {
    return _then(_value.copyWith(
        min: min == dimmutable ? _value.min : min as String,
        max: max == dimmutable ? _value.max : max as String));
  }
}

abstract class _$StringRangeCopyWith<O> implements $StringRangeCopyWith<O> {
  factory _$StringRangeCopyWith(
          StringRange value, O Function(StringRange) then) =
      __$StringRangeCopyWithImpl<O>;
  O call({String min, String max});
}

class __$StringRangeCopyWithImpl<O> extends _$StringRangeCopyWithImpl<O>
    implements _$StringRangeCopyWith<O> {
  __$StringRangeCopyWithImpl(StringRange _value, O Function(StringRange) _then)
      : super(_value, (v) => _then(v));

  @override
  StringRange get _value => super._value;

  @override
  O call({Object? min = dimmutable, Object? max = dimmutable}) {
    return _then(StringRange(
        min: min == dimmutable ? _value.min : min as String,
        max: max == dimmutable ? _value.max : max as String));
  }
}

@JsonSerializable()
class WithinFilter {
  final dynamic polygon;

  @JsonKey(ignore: true)
  _$WithinFilterCopyWith<WithinFilter> get copyWith =>
      __$WithinFilterCopyWithImpl<WithinFilter>(this, IdentityFn);

  const WithinFilter({required this.polygon});

  factory WithinFilter.fromJson(Map<String, dynamic> json) =>
      _$WithinFilterFromJson(json);

  Map<String, dynamic> toJson() => _$WithinFilterToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is WithinFilter && o.polygon == polygon;
  }

  @override
  int get hashCode => polygon.hashCode;

  @override
  String toString() => "WithinFilter(polygon: ${this.polygon})";
}

abstract class $WithinFilterCopyWith<O> {
  factory $WithinFilterCopyWith(
          WithinFilter value, O Function(WithinFilter) then) =
      _$WithinFilterCopyWithImpl<O>;
  O call({dynamic polygon});
}

class _$WithinFilterCopyWithImpl<O> implements $WithinFilterCopyWith<O> {
  final WithinFilter _value;
  final O Function(WithinFilter) _then;
  _$WithinFilterCopyWithImpl(this._value, this._then);

  @override
  O call({Object? polygon = dimmutable}) {
    return _then(_value.copyWith(
        polygon: polygon == dimmutable ? _value.polygon : polygon as dynamic));
  }
}

abstract class _$WithinFilterCopyWith<O> implements $WithinFilterCopyWith<O> {
  factory _$WithinFilterCopyWith(
          WithinFilter value, O Function(WithinFilter) then) =
      __$WithinFilterCopyWithImpl<O>;
  O call({dynamic polygon});
}

class __$WithinFilterCopyWithImpl<O> extends _$WithinFilterCopyWithImpl<O>
    implements _$WithinFilterCopyWith<O> {
  __$WithinFilterCopyWithImpl(
      WithinFilter _value, O Function(WithinFilter) _then)
      : super(_value, (v) => _then(v));

  @override
  WithinFilter get _value => super._value;

  @override
  O call({Object? polygon = dimmutable}) {
    return _then(WithinFilter(
        polygon: polygon == dimmutable ? _value.polygon : polygon as dynamic));
  }
}

@JsonSerializable()
class StringHashFilter {
  final String? eq;

  final List<String?>? d_in;

  @JsonKey(ignore: true)
  _$StringHashFilterCopyWith<StringHashFilter> get copyWith =>
      __$StringHashFilterCopyWithImpl<StringHashFilter>(this, IdentityFn);

  const StringHashFilter({this.eq, this.d_in});

  factory StringHashFilter.fromJson(Map<String, dynamic> json) =>
      _$StringHashFilterFromJson(json);

  Map<String, dynamic> toJson() => _$StringHashFilterToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is StringHashFilter && o.eq == eq && o.d_in == d_in;
  }

  @override
  int get hashCode => eq.hashCode ^ d_in.hashCode;

  @override
  String toString() => "StringHashFilter(eq: ${this.eq}, d_in: ${this.d_in})";
}

abstract class $StringHashFilterCopyWith<O> {
  factory $StringHashFilterCopyWith(
          StringHashFilter value, O Function(StringHashFilter) then) =
      _$StringHashFilterCopyWithImpl<O>;
  O call({String? eq, List<String?>? d_in});
}

class _$StringHashFilterCopyWithImpl<O>
    implements $StringHashFilterCopyWith<O> {
  final StringHashFilter _value;
  final O Function(StringHashFilter) _then;
  _$StringHashFilterCopyWithImpl(this._value, this._then);

  @override
  O call({Object? eq = dimmutable, Object? d_in = dimmutable}) {
    return _then(_value.copyWith(
        eq: eq == dimmutable ? _value.eq : eq as String?,
        d_in: d_in == dimmutable ? _value.d_in : d_in as List<String?>?));
  }
}

abstract class _$StringHashFilterCopyWith<O>
    implements $StringHashFilterCopyWith<O> {
  factory _$StringHashFilterCopyWith(
          StringHashFilter value, O Function(StringHashFilter) then) =
      __$StringHashFilterCopyWithImpl<O>;
  O call({String? eq, List<String?>? d_in});
}

class __$StringHashFilterCopyWithImpl<O>
    extends _$StringHashFilterCopyWithImpl<O>
    implements _$StringHashFilterCopyWith<O> {
  __$StringHashFilterCopyWithImpl(
      StringHashFilter _value, O Function(StringHashFilter) _then)
      : super(_value, (v) => _then(v));

  @override
  StringHashFilter get _value => super._value;

  @override
  O call({Object? eq = dimmutable, Object? d_in = dimmutable}) {
    return _then(StringHashFilter(
        eq: eq == dimmutable ? _value.eq : eq as String?,
        d_in: d_in == dimmutable ? _value.d_in : d_in as List<String?>?));
  }
}

@JsonSerializable()
class StringFullTextFilter {
  final String? alloftext;

  final String? anyoftext;

  @JsonKey(ignore: true)
  _$StringFullTextFilterCopyWith<StringFullTextFilter> get copyWith =>
      __$StringFullTextFilterCopyWithImpl<StringFullTextFilter>(
          this, IdentityFn);

  const StringFullTextFilter({this.alloftext, this.anyoftext});

  factory StringFullTextFilter.fromJson(Map<String, dynamic> json) =>
      _$StringFullTextFilterFromJson(json);

  Map<String, dynamic> toJson() => _$StringFullTextFilterToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is StringFullTextFilter &&
        o.alloftext == alloftext &&
        o.anyoftext == anyoftext;
  }

  @override
  int get hashCode => alloftext.hashCode ^ anyoftext.hashCode;

  @override
  String toString() =>
      "StringFullTextFilter(alloftext: ${this.alloftext}, anyoftext: ${this.anyoftext})";
}

abstract class $StringFullTextFilterCopyWith<O> {
  factory $StringFullTextFilterCopyWith(
          StringFullTextFilter value, O Function(StringFullTextFilter) then) =
      _$StringFullTextFilterCopyWithImpl<O>;
  O call({String? alloftext, String? anyoftext});
}

class _$StringFullTextFilterCopyWithImpl<O>
    implements $StringFullTextFilterCopyWith<O> {
  final StringFullTextFilter _value;
  final O Function(StringFullTextFilter) _then;
  _$StringFullTextFilterCopyWithImpl(this._value, this._then);

  @override
  O call({Object? alloftext = dimmutable, Object? anyoftext = dimmutable}) {
    return _then(_value.copyWith(
        alloftext:
            alloftext == dimmutable ? _value.alloftext : alloftext as String?,
        anyoftext:
            anyoftext == dimmutable ? _value.anyoftext : anyoftext as String?));
  }
}

abstract class _$StringFullTextFilterCopyWith<O>
    implements $StringFullTextFilterCopyWith<O> {
  factory _$StringFullTextFilterCopyWith(
          StringFullTextFilter value, O Function(StringFullTextFilter) then) =
      __$StringFullTextFilterCopyWithImpl<O>;
  O call({String? alloftext, String? anyoftext});
}

class __$StringFullTextFilterCopyWithImpl<O>
    extends _$StringFullTextFilterCopyWithImpl<O>
    implements _$StringFullTextFilterCopyWith<O> {
  __$StringFullTextFilterCopyWithImpl(
      StringFullTextFilter _value, O Function(StringFullTextFilter) _then)
      : super(_value, (v) => _then(v));

  @override
  StringFullTextFilter get _value => super._value;

  @override
  O call({Object? alloftext = dimmutable, Object? anyoftext = dimmutable}) {
    return _then(StringFullTextFilter(
        alloftext:
            alloftext == dimmutable ? _value.alloftext : alloftext as String?,
        anyoftext:
            anyoftext == dimmutable ? _value.anyoftext : anyoftext as String?));
  }
}

@JsonSerializable()
class UpdateTaskInput {
  final dynamic filter;

  final dynamic? set;

  final dynamic? remove;

  @JsonKey(ignore: true)
  _$UpdateTaskInputCopyWith<UpdateTaskInput> get copyWith =>
      __$UpdateTaskInputCopyWithImpl<UpdateTaskInput>(this, IdentityFn);

  const UpdateTaskInput({required this.filter, this.set, this.remove});

  factory UpdateTaskInput.fromJson(Map<String, dynamic> json) =>
      _$UpdateTaskInputFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateTaskInputToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is UpdateTaskInput &&
        o.filter == filter &&
        o.set == set &&
        o.remove == remove;
  }

  @override
  int get hashCode => filter.hashCode ^ set.hashCode ^ remove.hashCode;

  @override
  String toString() =>
      "UpdateTaskInput(filter: ${this.filter}, set: ${this.set}, remove: ${this.remove})";
}

abstract class $UpdateTaskInputCopyWith<O> {
  factory $UpdateTaskInputCopyWith(
          UpdateTaskInput value, O Function(UpdateTaskInput) then) =
      _$UpdateTaskInputCopyWithImpl<O>;
  O call({dynamic filter, dynamic? set, dynamic? remove});
}

class _$UpdateTaskInputCopyWithImpl<O> implements $UpdateTaskInputCopyWith<O> {
  final UpdateTaskInput _value;
  final O Function(UpdateTaskInput) _then;
  _$UpdateTaskInputCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? filter = dimmutable,
      Object? set = dimmutable,
      Object? remove = dimmutable}) {
    return _then(_value.copyWith(
        filter: filter == dimmutable ? _value.filter : filter as dynamic,
        set: set == dimmutable ? _value.set : set as dynamic?,
        remove: remove == dimmutable ? _value.remove : remove as dynamic?));
  }
}

abstract class _$UpdateTaskInputCopyWith<O>
    implements $UpdateTaskInputCopyWith<O> {
  factory _$UpdateTaskInputCopyWith(
          UpdateTaskInput value, O Function(UpdateTaskInput) then) =
      __$UpdateTaskInputCopyWithImpl<O>;
  O call({dynamic filter, dynamic? set, dynamic? remove});
}

class __$UpdateTaskInputCopyWithImpl<O> extends _$UpdateTaskInputCopyWithImpl<O>
    implements _$UpdateTaskInputCopyWith<O> {
  __$UpdateTaskInputCopyWithImpl(
      UpdateTaskInput _value, O Function(UpdateTaskInput) _then)
      : super(_value, (v) => _then(v));

  @override
  UpdateTaskInput get _value => super._value;

  @override
  O call(
      {Object? filter = dimmutable,
      Object? set = dimmutable,
      Object? remove = dimmutable}) {
    return _then(UpdateTaskInput(
        filter: filter == dimmutable ? _value.filter : filter as dynamic,
        set: set == dimmutable ? _value.set : set as dynamic?,
        remove: remove == dimmutable ? _value.remove : remove as dynamic?));
  }
}

@JsonSerializable()
class StringRegExpFilter {
  final String? regexp;

  @JsonKey(ignore: true)
  _$StringRegExpFilterCopyWith<StringRegExpFilter> get copyWith =>
      __$StringRegExpFilterCopyWithImpl<StringRegExpFilter>(this, IdentityFn);

  const StringRegExpFilter({this.regexp});

  factory StringRegExpFilter.fromJson(Map<String, dynamic> json) =>
      _$StringRegExpFilterFromJson(json);

  Map<String, dynamic> toJson() => _$StringRegExpFilterToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is StringRegExpFilter && o.regexp == regexp;
  }

  @override
  int get hashCode => regexp.hashCode;

  @override
  String toString() => "StringRegExpFilter(regexp: ${this.regexp})";
}

abstract class $StringRegExpFilterCopyWith<O> {
  factory $StringRegExpFilterCopyWith(
          StringRegExpFilter value, O Function(StringRegExpFilter) then) =
      _$StringRegExpFilterCopyWithImpl<O>;
  O call({String? regexp});
}

class _$StringRegExpFilterCopyWithImpl<O>
    implements $StringRegExpFilterCopyWith<O> {
  final StringRegExpFilter _value;
  final O Function(StringRegExpFilter) _then;
  _$StringRegExpFilterCopyWithImpl(this._value, this._then);

  @override
  O call({Object? regexp = dimmutable}) {
    return _then(_value.copyWith(
        regexp: regexp == dimmutable ? _value.regexp : regexp as String?));
  }
}

abstract class _$StringRegExpFilterCopyWith<O>
    implements $StringRegExpFilterCopyWith<O> {
  factory _$StringRegExpFilterCopyWith(
          StringRegExpFilter value, O Function(StringRegExpFilter) then) =
      __$StringRegExpFilterCopyWithImpl<O>;
  O call({String? regexp});
}

class __$StringRegExpFilterCopyWithImpl<O>
    extends _$StringRegExpFilterCopyWithImpl<O>
    implements _$StringRegExpFilterCopyWith<O> {
  __$StringRegExpFilterCopyWithImpl(
      StringRegExpFilter _value, O Function(StringRegExpFilter) _then)
      : super(_value, (v) => _then(v));

  @override
  StringRegExpFilter get _value => super._value;

  @override
  O call({Object? regexp = dimmutable}) {
    return _then(StringRegExpFilter(
        regexp: regexp == dimmutable ? _value.regexp : regexp as String?));
  }
}

@JsonSerializable()
class TaskPatch {
  final String? title;

  final bool? completed;

  final dynamic? user;

  @JsonKey(ignore: true)
  _$TaskPatchCopyWith<TaskPatch> get copyWith =>
      __$TaskPatchCopyWithImpl<TaskPatch>(this, IdentityFn);

  const TaskPatch({this.title, this.completed, this.user});

  factory TaskPatch.fromJson(Map<String, dynamic> json) =>
      _$TaskPatchFromJson(json);

  Map<String, dynamic> toJson() => _$TaskPatchToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is TaskPatch &&
        o.title == title &&
        o.completed == completed &&
        o.user == user;
  }

  @override
  int get hashCode => title.hashCode ^ completed.hashCode ^ user.hashCode;

  @override
  String toString() =>
      "TaskPatch(title: ${this.title}, completed: ${this.completed}, user: ${this.user})";
}

abstract class $TaskPatchCopyWith<O> {
  factory $TaskPatchCopyWith(TaskPatch value, O Function(TaskPatch) then) =
      _$TaskPatchCopyWithImpl<O>;
  O call({String? title, bool? completed, dynamic? user});
}

class _$TaskPatchCopyWithImpl<O> implements $TaskPatchCopyWith<O> {
  final TaskPatch _value;
  final O Function(TaskPatch) _then;
  _$TaskPatchCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? title = dimmutable,
      Object? completed = dimmutable,
      Object? user = dimmutable}) {
    return _then(_value.copyWith(
        title: title == dimmutable ? _value.title : title as String?,
        completed:
            completed == dimmutable ? _value.completed : completed as bool?,
        user: user == dimmutable ? _value.user : user as dynamic?));
  }
}

abstract class _$TaskPatchCopyWith<O> implements $TaskPatchCopyWith<O> {
  factory _$TaskPatchCopyWith(TaskPatch value, O Function(TaskPatch) then) =
      __$TaskPatchCopyWithImpl<O>;
  O call({String? title, bool? completed, dynamic? user});
}

class __$TaskPatchCopyWithImpl<O> extends _$TaskPatchCopyWithImpl<O>
    implements _$TaskPatchCopyWith<O> {
  __$TaskPatchCopyWithImpl(TaskPatch _value, O Function(TaskPatch) _then)
      : super(_value, (v) => _then(v));

  @override
  TaskPatch get _value => super._value;

  @override
  O call(
      {Object? title = dimmutable,
      Object? completed = dimmutable,
      Object? user = dimmutable}) {
    return _then(TaskPatch(
        title: title == dimmutable ? _value.title : title as String?,
        completed:
            completed == dimmutable ? _value.completed : completed as bool?,
        user: user == dimmutable ? _value.user : user as dynamic?));
  }
}

@JsonSerializable()
class UserRef {
  final String? username;

  final String? name;

  final List<dynamic?>? tasks;

  @JsonKey(ignore: true)
  _$UserRefCopyWith<UserRef> get copyWith =>
      __$UserRefCopyWithImpl<UserRef>(this, IdentityFn);

  const UserRef({this.username, this.name, this.tasks});

  factory UserRef.fromJson(Map<String, dynamic> json) =>
      _$UserRefFromJson(json);

  Map<String, dynamic> toJson() => _$UserRefToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is UserRef &&
        o.username == username &&
        o.name == name &&
        o.tasks == tasks;
  }

  @override
  int get hashCode => username.hashCode ^ name.hashCode ^ tasks.hashCode;

  @override
  String toString() =>
      "UserRef(username: ${this.username}, name: ${this.name}, tasks: ${this.tasks})";
}

abstract class $UserRefCopyWith<O> {
  factory $UserRefCopyWith(UserRef value, O Function(UserRef) then) =
      _$UserRefCopyWithImpl<O>;
  O call({String? username, String? name, List<dynamic?>? tasks});
}

class _$UserRefCopyWithImpl<O> implements $UserRefCopyWith<O> {
  final UserRef _value;
  final O Function(UserRef) _then;
  _$UserRefCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? username = dimmutable,
      Object? name = dimmutable,
      Object? tasks = dimmutable}) {
    return _then(_value.copyWith(
        username:
            username == dimmutable ? _value.username : username as String?,
        name: name == dimmutable ? _value.name : name as String?,
        tasks: tasks == dimmutable ? _value.tasks : tasks as List<dynamic?>?));
  }
}

abstract class _$UserRefCopyWith<O> implements $UserRefCopyWith<O> {
  factory _$UserRefCopyWith(UserRef value, O Function(UserRef) then) =
      __$UserRefCopyWithImpl<O>;
  O call({String? username, String? name, List<dynamic?>? tasks});
}

class __$UserRefCopyWithImpl<O> extends _$UserRefCopyWithImpl<O>
    implements _$UserRefCopyWith<O> {
  __$UserRefCopyWithImpl(UserRef _value, O Function(UserRef) _then)
      : super(_value, (v) => _then(v));

  @override
  UserRef get _value => super._value;

  @override
  O call(
      {Object? username = dimmutable,
      Object? name = dimmutable,
      Object? tasks = dimmutable}) {
    return _then(UserRef(
        username:
            username == dimmutable ? _value.username : username as String?,
        name: name == dimmutable ? _value.name : name as String?,
        tasks: tasks == dimmutable ? _value.tasks : tasks as List<dynamic?>?));
  }
}

@JsonSerializable()
class FloatRange {
  final double min;

  final double max;

  @JsonKey(ignore: true)
  _$FloatRangeCopyWith<FloatRange> get copyWith =>
      __$FloatRangeCopyWithImpl<FloatRange>(this, IdentityFn);

  const FloatRange({required this.min, required this.max});

  factory FloatRange.fromJson(Map<String, dynamic> json) =>
      _$FloatRangeFromJson(json);

  Map<String, dynamic> toJson() => _$FloatRangeToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is FloatRange && o.min == min && o.max == max;
  }

  @override
  int get hashCode => min.hashCode ^ max.hashCode;

  @override
  String toString() => "FloatRange(min: ${this.min}, max: ${this.max})";
}

abstract class $FloatRangeCopyWith<O> {
  factory $FloatRangeCopyWith(FloatRange value, O Function(FloatRange) then) =
      _$FloatRangeCopyWithImpl<O>;
  O call({double min, double max});
}

class _$FloatRangeCopyWithImpl<O> implements $FloatRangeCopyWith<O> {
  final FloatRange _value;
  final O Function(FloatRange) _then;
  _$FloatRangeCopyWithImpl(this._value, this._then);

  @override
  O call({Object? min = dimmutable, Object? max = dimmutable}) {
    return _then(_value.copyWith(
        min: min == dimmutable ? _value.min : min as double,
        max: max == dimmutable ? _value.max : max as double));
  }
}

abstract class _$FloatRangeCopyWith<O> implements $FloatRangeCopyWith<O> {
  factory _$FloatRangeCopyWith(FloatRange value, O Function(FloatRange) then) =
      __$FloatRangeCopyWithImpl<O>;
  O call({double min, double max});
}

class __$FloatRangeCopyWithImpl<O> extends _$FloatRangeCopyWithImpl<O>
    implements _$FloatRangeCopyWith<O> {
  __$FloatRangeCopyWithImpl(FloatRange _value, O Function(FloatRange) _then)
      : super(_value, (v) => _then(v));

  @override
  FloatRange get _value => super._value;

  @override
  O call({Object? min = dimmutable, Object? max = dimmutable}) {
    return _then(FloatRange(
        min: min == dimmutable ? _value.min : min as double,
        max: max == dimmutable ? _value.max : max as double));
  }
}

@JsonSerializable()
class FloatFilter {
  final double? eq;

  final double? le;

  final double? lt;

  final double? ge;

  final double? gt;

  final dynamic? between;

  @JsonKey(ignore: true)
  _$FloatFilterCopyWith<FloatFilter> get copyWith =>
      __$FloatFilterCopyWithImpl<FloatFilter>(this, IdentityFn);

  const FloatFilter(
      {this.eq, this.le, this.lt, this.ge, this.gt, this.between});

  factory FloatFilter.fromJson(Map<String, dynamic> json) =>
      _$FloatFilterFromJson(json);

  Map<String, dynamic> toJson() => _$FloatFilterToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is FloatFilter &&
        o.eq == eq &&
        o.le == le &&
        o.lt == lt &&
        o.ge == ge &&
        o.gt == gt &&
        o.between == between;
  }

  @override
  int get hashCode =>
      eq.hashCode ^
      le.hashCode ^
      lt.hashCode ^
      ge.hashCode ^
      gt.hashCode ^
      between.hashCode;

  @override
  String toString() =>
      "FloatFilter(eq: ${this.eq}, le: ${this.le}, lt: ${this.lt}, ge: ${this.ge}, gt: ${this.gt}, between: ${this.between})";
}

abstract class $FloatFilterCopyWith<O> {
  factory $FloatFilterCopyWith(
          FloatFilter value, O Function(FloatFilter) then) =
      _$FloatFilterCopyWithImpl<O>;
  O call(
      {double? eq,
      double? le,
      double? lt,
      double? ge,
      double? gt,
      dynamic? between});
}

class _$FloatFilterCopyWithImpl<O> implements $FloatFilterCopyWith<O> {
  final FloatFilter _value;
  final O Function(FloatFilter) _then;
  _$FloatFilterCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? eq = dimmutable,
      Object? le = dimmutable,
      Object? lt = dimmutable,
      Object? ge = dimmutable,
      Object? gt = dimmutable,
      Object? between = dimmutable}) {
    return _then(_value.copyWith(
        eq: eq == dimmutable ? _value.eq : eq as double?,
        le: le == dimmutable ? _value.le : le as double?,
        lt: lt == dimmutable ? _value.lt : lt as double?,
        ge: ge == dimmutable ? _value.ge : ge as double?,
        gt: gt == dimmutable ? _value.gt : gt as double?,
        between: between == dimmutable ? _value.between : between as dynamic?));
  }
}

abstract class _$FloatFilterCopyWith<O> implements $FloatFilterCopyWith<O> {
  factory _$FloatFilterCopyWith(
          FloatFilter value, O Function(FloatFilter) then) =
      __$FloatFilterCopyWithImpl<O>;
  O call(
      {double? eq,
      double? le,
      double? lt,
      double? ge,
      double? gt,
      dynamic? between});
}

class __$FloatFilterCopyWithImpl<O> extends _$FloatFilterCopyWithImpl<O>
    implements _$FloatFilterCopyWith<O> {
  __$FloatFilterCopyWithImpl(FloatFilter _value, O Function(FloatFilter) _then)
      : super(_value, (v) => _then(v));

  @override
  FloatFilter get _value => super._value;

  @override
  O call(
      {Object? eq = dimmutable,
      Object? le = dimmutable,
      Object? lt = dimmutable,
      Object? ge = dimmutable,
      Object? gt = dimmutable,
      Object? between = dimmutable}) {
    return _then(FloatFilter(
        eq: eq == dimmutable ? _value.eq : eq as double?,
        le: le == dimmutable ? _value.le : le as double?,
        lt: lt == dimmutable ? _value.lt : lt as double?,
        ge: ge == dimmutable ? _value.ge : ge as double?,
        gt: gt == dimmutable ? _value.gt : gt as double?,
        between: between == dimmutable ? _value.between : between as dynamic?));
  }
}

@JsonSerializable()
class HelloI {
  final int? n;

  @JsonKey(ignore: true)
  _$HelloICopyWith<HelloI> get copyWith =>
      __$HelloICopyWithImpl<HelloI>(this, IdentityFn);

  const HelloI({this.n});

  factory HelloI.fromJson(Map<String, dynamic> json) => _$HelloIFromJson(json);

  Map<String, dynamic> toJson() => _$HelloIToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is HelloI && o.n == n;
  }

  @override
  int get hashCode => n.hashCode;

  @override
  String toString() => "HelloI(n: ${this.n})";
}

abstract class $HelloICopyWith<O> {
  factory $HelloICopyWith(HelloI value, O Function(HelloI) then) =
      _$HelloICopyWithImpl<O>;
  O call({int? n});
}

class _$HelloICopyWithImpl<O> implements $HelloICopyWith<O> {
  final HelloI _value;
  final O Function(HelloI) _then;
  _$HelloICopyWithImpl(this._value, this._then);

  @override
  O call({Object? n = dimmutable}) {
    return _then(_value.copyWith(n: n == dimmutable ? _value.n : n as int?));
  }
}

abstract class _$HelloICopyWith<O> implements $HelloICopyWith<O> {
  factory _$HelloICopyWith(HelloI value, O Function(HelloI) then) =
      __$HelloICopyWithImpl<O>;
  O call({int? n});
}

class __$HelloICopyWithImpl<O> extends _$HelloICopyWithImpl<O>
    implements _$HelloICopyWith<O> {
  __$HelloICopyWithImpl(HelloI _value, O Function(HelloI) _then)
      : super(_value, (v) => _then(v));

  @override
  HelloI get _value => super._value;

  @override
  O call({Object? n = dimmutable}) {
    return _then(HelloI(n: n == dimmutable ? _value.n : n as int?));
  }
}

@JsonSerializable()
class TaskFilter {
  final List<String>? id;

  final bool? completed;

  final dynamic? has;

  final List<dynamic?>? and;

  final List<dynamic?>? or;

  final dynamic? not;

  @JsonKey(ignore: true)
  _$TaskFilterCopyWith<TaskFilter> get copyWith =>
      __$TaskFilterCopyWithImpl<TaskFilter>(this, IdentityFn);

  const TaskFilter(
      {this.id, this.completed, this.has, this.and, this.or, this.not});

  factory TaskFilter.fromJson(Map<String, dynamic> json) =>
      _$TaskFilterFromJson(json);

  Map<String, dynamic> toJson() => _$TaskFilterToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is TaskFilter &&
        o.id == id &&
        o.completed == completed &&
        o.has == has &&
        o.and == and &&
        o.or == or &&
        o.not == not;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      completed.hashCode ^
      has.hashCode ^
      and.hashCode ^
      or.hashCode ^
      not.hashCode;

  @override
  String toString() =>
      "TaskFilter(id: ${this.id}, completed: ${this.completed}, has: ${this.has}, and: ${this.and}, or: ${this.or}, not: ${this.not})";
}

abstract class $TaskFilterCopyWith<O> {
  factory $TaskFilterCopyWith(TaskFilter value, O Function(TaskFilter) then) =
      _$TaskFilterCopyWithImpl<O>;
  O call(
      {List<String>? id,
      bool? completed,
      dynamic? has,
      List<dynamic?>? and,
      List<dynamic?>? or,
      dynamic? not});
}

class _$TaskFilterCopyWithImpl<O> implements $TaskFilterCopyWith<O> {
  final TaskFilter _value;
  final O Function(TaskFilter) _then;
  _$TaskFilterCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? id = dimmutable,
      Object? completed = dimmutable,
      Object? has = dimmutable,
      Object? and = dimmutable,
      Object? or = dimmutable,
      Object? not = dimmutable}) {
    return _then(_value.copyWith(
        id: id == dimmutable ? _value.id : id as List<String>?,
        completed:
            completed == dimmutable ? _value.completed : completed as bool?,
        has: has == dimmutable ? _value.has : has as dynamic?,
        and: and == dimmutable ? _value.and : and as List<dynamic?>?,
        or: or == dimmutable ? _value.or : or as List<dynamic?>?,
        not: not == dimmutable ? _value.not : not as dynamic?));
  }
}

abstract class _$TaskFilterCopyWith<O> implements $TaskFilterCopyWith<O> {
  factory _$TaskFilterCopyWith(TaskFilter value, O Function(TaskFilter) then) =
      __$TaskFilterCopyWithImpl<O>;
  O call(
      {List<String>? id,
      bool? completed,
      dynamic? has,
      List<dynamic?>? and,
      List<dynamic?>? or,
      dynamic? not});
}

class __$TaskFilterCopyWithImpl<O> extends _$TaskFilterCopyWithImpl<O>
    implements _$TaskFilterCopyWith<O> {
  __$TaskFilterCopyWithImpl(TaskFilter _value, O Function(TaskFilter) _then)
      : super(_value, (v) => _then(v));

  @override
  TaskFilter get _value => super._value;

  @override
  O call(
      {Object? id = dimmutable,
      Object? completed = dimmutable,
      Object? has = dimmutable,
      Object? and = dimmutable,
      Object? or = dimmutable,
      Object? not = dimmutable}) {
    return _then(TaskFilter(
        id: id == dimmutable ? _value.id : id as List<String>?,
        completed:
            completed == dimmutable ? _value.completed : completed as bool?,
        has: has == dimmutable ? _value.has : has as dynamic?,
        and: and == dimmutable ? _value.and : and as List<dynamic?>?,
        or: or == dimmutable ? _value.or : or as List<dynamic?>?,
        not: not == dimmutable ? _value.not : not as dynamic?));
  }
}

@JsonSerializable()
class PointRef {
  final double longitude;

  final double latitude;

  @JsonKey(ignore: true)
  _$PointRefCopyWith<PointRef> get copyWith =>
      __$PointRefCopyWithImpl<PointRef>(this, IdentityFn);

  const PointRef({required this.longitude, required this.latitude});

  factory PointRef.fromJson(Map<String, dynamic> json) =>
      _$PointRefFromJson(json);

  Map<String, dynamic> toJson() => _$PointRefToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is PointRef && o.longitude == longitude && o.latitude == latitude;
  }

  @override
  int get hashCode => longitude.hashCode ^ latitude.hashCode;

  @override
  String toString() =>
      "PointRef(longitude: ${this.longitude}, latitude: ${this.latitude})";
}

abstract class $PointRefCopyWith<O> {
  factory $PointRefCopyWith(PointRef value, O Function(PointRef) then) =
      _$PointRefCopyWithImpl<O>;
  O call({double longitude, double latitude});
}

class _$PointRefCopyWithImpl<O> implements $PointRefCopyWith<O> {
  final PointRef _value;
  final O Function(PointRef) _then;
  _$PointRefCopyWithImpl(this._value, this._then);

  @override
  O call({Object? longitude = dimmutable, Object? latitude = dimmutable}) {
    return _then(_value.copyWith(
        longitude:
            longitude == dimmutable ? _value.longitude : longitude as double,
        latitude:
            latitude == dimmutable ? _value.latitude : latitude as double));
  }
}

abstract class _$PointRefCopyWith<O> implements $PointRefCopyWith<O> {
  factory _$PointRefCopyWith(PointRef value, O Function(PointRef) then) =
      __$PointRefCopyWithImpl<O>;
  O call({double longitude, double latitude});
}

class __$PointRefCopyWithImpl<O> extends _$PointRefCopyWithImpl<O>
    implements _$PointRefCopyWith<O> {
  __$PointRefCopyWithImpl(PointRef _value, O Function(PointRef) _then)
      : super(_value, (v) => _then(v));

  @override
  PointRef get _value => super._value;

  @override
  O call({Object? longitude = dimmutable, Object? latitude = dimmutable}) {
    return _then(PointRef(
        longitude:
            longitude == dimmutable ? _value.longitude : longitude as double,
        latitude:
            latitude == dimmutable ? _value.latitude : latitude as double));
  }
}

@JsonSerializable()
class AuthorOrder {
  final dynamic? asc;

  final dynamic? desc;

  final dynamic? then;

  @JsonKey(ignore: true)
  _$AuthorOrderCopyWith<AuthorOrder> get copyWith =>
      __$AuthorOrderCopyWithImpl<AuthorOrder>(this, IdentityFn);

  const AuthorOrder({this.asc, this.desc, this.then});

  factory AuthorOrder.fromJson(Map<String, dynamic> json) =>
      _$AuthorOrderFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorOrderToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is AuthorOrder && o.asc == asc && o.desc == desc && o.then == then;
  }

  @override
  int get hashCode => asc.hashCode ^ desc.hashCode ^ then.hashCode;

  @override
  String toString() =>
      "AuthorOrder(asc: ${this.asc}, desc: ${this.desc}, then: ${this.then})";
}

abstract class $AuthorOrderCopyWith<O> {
  factory $AuthorOrderCopyWith(
          AuthorOrder value, O Function(AuthorOrder) then) =
      _$AuthorOrderCopyWithImpl<O>;
  O call({dynamic? asc, dynamic? desc, dynamic? then});
}

class _$AuthorOrderCopyWithImpl<O> implements $AuthorOrderCopyWith<O> {
  final AuthorOrder _value;
  final O Function(AuthorOrder) _then;
  _$AuthorOrderCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? asc = dimmutable,
      Object? desc = dimmutable,
      Object? then = dimmutable}) {
    return _then(_value.copyWith(
        asc: asc == dimmutable ? _value.asc : asc as dynamic?,
        desc: desc == dimmutable ? _value.desc : desc as dynamic?,
        then: then == dimmutable ? _value.then : then as dynamic?));
  }
}

abstract class _$AuthorOrderCopyWith<O> implements $AuthorOrderCopyWith<O> {
  factory _$AuthorOrderCopyWith(
          AuthorOrder value, O Function(AuthorOrder) then) =
      __$AuthorOrderCopyWithImpl<O>;
  O call({dynamic? asc, dynamic? desc, dynamic? then});
}

class __$AuthorOrderCopyWithImpl<O> extends _$AuthorOrderCopyWithImpl<O>
    implements _$AuthorOrderCopyWith<O> {
  __$AuthorOrderCopyWithImpl(AuthorOrder _value, O Function(AuthorOrder) _then)
      : super(_value, (v) => _then(v));

  @override
  AuthorOrder get _value => super._value;

  @override
  O call(
      {Object? asc = dimmutable,
      Object? desc = dimmutable,
      Object? then = dimmutable}) {
    return _then(AuthorOrder(
        asc: asc == dimmutable ? _value.asc : asc as dynamic?,
        desc: desc == dimmutable ? _value.desc : desc as dynamic?,
        then: then == dimmutable ? _value.then : then as dynamic?));
  }
}

@JsonSerializable()
class DateTimeRange {
  final dynamic min;

  final dynamic max;

  @JsonKey(ignore: true)
  _$DateTimeRangeCopyWith<DateTimeRange> get copyWith =>
      __$DateTimeRangeCopyWithImpl<DateTimeRange>(this, IdentityFn);

  const DateTimeRange({required this.min, required this.max});

  factory DateTimeRange.fromJson(Map<String, dynamic> json) =>
      _$DateTimeRangeFromJson(json);

  Map<String, dynamic> toJson() => _$DateTimeRangeToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is DateTimeRange && o.min == min && o.max == max;
  }

  @override
  int get hashCode => min.hashCode ^ max.hashCode;

  @override
  String toString() => "DateTimeRange(min: ${this.min}, max: ${this.max})";
}

abstract class $DateTimeRangeCopyWith<O> {
  factory $DateTimeRangeCopyWith(
          DateTimeRange value, O Function(DateTimeRange) then) =
      _$DateTimeRangeCopyWithImpl<O>;
  O call({dynamic min, dynamic max});
}

class _$DateTimeRangeCopyWithImpl<O> implements $DateTimeRangeCopyWith<O> {
  final DateTimeRange _value;
  final O Function(DateTimeRange) _then;
  _$DateTimeRangeCopyWithImpl(this._value, this._then);

  @override
  O call({Object? min = dimmutable, Object? max = dimmutable}) {
    return _then(_value.copyWith(
        min: min == dimmutable ? _value.min : min as dynamic,
        max: max == dimmutable ? _value.max : max as dynamic));
  }
}

abstract class _$DateTimeRangeCopyWith<O> implements $DateTimeRangeCopyWith<O> {
  factory _$DateTimeRangeCopyWith(
          DateTimeRange value, O Function(DateTimeRange) then) =
      __$DateTimeRangeCopyWithImpl<O>;
  O call({dynamic min, dynamic max});
}

class __$DateTimeRangeCopyWithImpl<O> extends _$DateTimeRangeCopyWithImpl<O>
    implements _$DateTimeRangeCopyWith<O> {
  __$DateTimeRangeCopyWithImpl(
      DateTimeRange _value, O Function(DateTimeRange) _then)
      : super(_value, (v) => _then(v));

  @override
  DateTimeRange get _value => super._value;

  @override
  O call({Object? min = dimmutable, Object? max = dimmutable}) {
    return _then(DateTimeRange(
        min: min == dimmutable ? _value.min : min as dynamic,
        max: max == dimmutable ? _value.max : max as dynamic));
  }
}

@JsonSerializable()
class PointListRef {
  final List<dynamic> points;

  @JsonKey(ignore: true)
  _$PointListRefCopyWith<PointListRef> get copyWith =>
      __$PointListRefCopyWithImpl<PointListRef>(this, IdentityFn);

  const PointListRef({required this.points});

  factory PointListRef.fromJson(Map<String, dynamic> json) =>
      _$PointListRefFromJson(json);

  Map<String, dynamic> toJson() => _$PointListRefToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is PointListRef && o.points == points;
  }

  @override
  int get hashCode => points.hashCode;

  @override
  String toString() => "PointListRef(points: ${this.points})";
}

abstract class $PointListRefCopyWith<O> {
  factory $PointListRefCopyWith(
          PointListRef value, O Function(PointListRef) then) =
      _$PointListRefCopyWithImpl<O>;
  O call({List<dynamic> points});
}

class _$PointListRefCopyWithImpl<O> implements $PointListRefCopyWith<O> {
  final PointListRef _value;
  final O Function(PointListRef) _then;
  _$PointListRefCopyWithImpl(this._value, this._then);

  @override
  O call({Object? points = dimmutable}) {
    return _then(_value.copyWith(
        points:
            points == dimmutable ? _value.points : points as List<dynamic>));
  }
}

abstract class _$PointListRefCopyWith<O> implements $PointListRefCopyWith<O> {
  factory _$PointListRefCopyWith(
          PointListRef value, O Function(PointListRef) then) =
      __$PointListRefCopyWithImpl<O>;
  O call({List<dynamic> points});
}

class __$PointListRefCopyWithImpl<O> extends _$PointListRefCopyWithImpl<O>
    implements _$PointListRefCopyWith<O> {
  __$PointListRefCopyWithImpl(
      PointListRef _value, O Function(PointListRef) _then)
      : super(_value, (v) => _then(v));

  @override
  PointListRef get _value => super._value;

  @override
  O call({Object? points = dimmutable}) {
    return _then(PointListRef(
        points:
            points == dimmutable ? _value.points : points as List<dynamic>));
  }
}

@JsonSerializable()
class AddAuthorInput {
  final String name;

  final List<dynamic>? posts;

  final List<dynamic?>? friends;

  final int? n;

  @JsonKey(ignore: true)
  _$AddAuthorInputCopyWith<AddAuthorInput> get copyWith =>
      __$AddAuthorInputCopyWithImpl<AddAuthorInput>(this, IdentityFn);

  const AddAuthorInput({required this.name, this.posts, this.friends, this.n});

  factory AddAuthorInput.fromJson(Map<String, dynamic> json) =>
      _$AddAuthorInputFromJson(json);

  Map<String, dynamic> toJson() => _$AddAuthorInputToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is AddAuthorInput &&
        o.name == name &&
        o.posts == posts &&
        o.friends == friends &&
        o.n == n;
  }

  @override
  int get hashCode =>
      name.hashCode ^ posts.hashCode ^ friends.hashCode ^ n.hashCode;

  @override
  String toString() =>
      "AddAuthorInput(name: ${this.name}, posts: ${this.posts}, friends: ${this.friends}, n: ${this.n})";
}

abstract class $AddAuthorInputCopyWith<O> {
  factory $AddAuthorInputCopyWith(
          AddAuthorInput value, O Function(AddAuthorInput) then) =
      _$AddAuthorInputCopyWithImpl<O>;
  O call({String name, List<dynamic>? posts, List<dynamic?>? friends, int? n});
}

class _$AddAuthorInputCopyWithImpl<O> implements $AddAuthorInputCopyWith<O> {
  final AddAuthorInput _value;
  final O Function(AddAuthorInput) _then;
  _$AddAuthorInputCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? name = dimmutable,
      Object? posts = dimmutable,
      Object? friends = dimmutable,
      Object? n = dimmutable}) {
    return _then(_value.copyWith(
        name: name == dimmutable ? _value.name : name as String,
        posts: posts == dimmutable ? _value.posts : posts as List<dynamic>?,
        friends:
            friends == dimmutable ? _value.friends : friends as List<dynamic?>?,
        n: n == dimmutable ? _value.n : n as int?));
  }
}

abstract class _$AddAuthorInputCopyWith<O>
    implements $AddAuthorInputCopyWith<O> {
  factory _$AddAuthorInputCopyWith(
          AddAuthorInput value, O Function(AddAuthorInput) then) =
      __$AddAuthorInputCopyWithImpl<O>;
  O call({String name, List<dynamic>? posts, List<dynamic?>? friends, int? n});
}

class __$AddAuthorInputCopyWithImpl<O> extends _$AddAuthorInputCopyWithImpl<O>
    implements _$AddAuthorInputCopyWith<O> {
  __$AddAuthorInputCopyWithImpl(
      AddAuthorInput _value, O Function(AddAuthorInput) _then)
      : super(_value, (v) => _then(v));

  @override
  AddAuthorInput get _value => super._value;

  @override
  O call(
      {Object? name = dimmutable,
      Object? posts = dimmutable,
      Object? friends = dimmutable,
      Object? n = dimmutable}) {
    return _then(AddAuthorInput(
        name: name == dimmutable ? _value.name : name as String,
        posts: posts == dimmutable ? _value.posts : posts as List<dynamic>?,
        friends:
            friends == dimmutable ? _value.friends : friends as List<dynamic?>?,
        n: n == dimmutable ? _value.n : n as int?));
  }
}

@JsonSerializable()
class PostFilter {
  final List<String>? id;

  final dynamic? title;

  final dynamic? score;

  final bool? completed;

  final dynamic? datePublished;

  final dynamic? has;

  final List<dynamic?>? and;

  final List<dynamic?>? or;

  final dynamic? not;

  @JsonKey(ignore: true)
  _$PostFilterCopyWith<PostFilter> get copyWith =>
      __$PostFilterCopyWithImpl<PostFilter>(this, IdentityFn);

  const PostFilter(
      {this.id,
      this.title,
      this.score,
      this.completed,
      this.datePublished,
      this.has,
      this.and,
      this.or,
      this.not});

  factory PostFilter.fromJson(Map<String, dynamic> json) =>
      _$PostFilterFromJson(json);

  Map<String, dynamic> toJson() => _$PostFilterToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is PostFilter &&
        o.id == id &&
        o.title == title &&
        o.score == score &&
        o.completed == completed &&
        o.datePublished == datePublished &&
        o.has == has &&
        o.and == and &&
        o.or == or &&
        o.not == not;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      score.hashCode ^
      completed.hashCode ^
      datePublished.hashCode ^
      has.hashCode ^
      and.hashCode ^
      or.hashCode ^
      not.hashCode;

  @override
  String toString() =>
      "PostFilter(id: ${this.id}, title: ${this.title}, score: ${this.score}, completed: ${this.completed}, datePublished: ${this.datePublished}, has: ${this.has}, and: ${this.and}, or: ${this.or}, not: ${this.not})";
}

abstract class $PostFilterCopyWith<O> {
  factory $PostFilterCopyWith(PostFilter value, O Function(PostFilter) then) =
      _$PostFilterCopyWithImpl<O>;
  O call(
      {List<String>? id,
      dynamic? title,
      dynamic? score,
      bool? completed,
      dynamic? datePublished,
      dynamic? has,
      List<dynamic?>? and,
      List<dynamic?>? or,
      dynamic? not});
}

class _$PostFilterCopyWithImpl<O> implements $PostFilterCopyWith<O> {
  final PostFilter _value;
  final O Function(PostFilter) _then;
  _$PostFilterCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? id = dimmutable,
      Object? title = dimmutable,
      Object? score = dimmutable,
      Object? completed = dimmutable,
      Object? datePublished = dimmutable,
      Object? has = dimmutable,
      Object? and = dimmutable,
      Object? or = dimmutable,
      Object? not = dimmutable}) {
    return _then(_value.copyWith(
        id: id == dimmutable ? _value.id : id as List<String>?,
        title: title == dimmutable ? _value.title : title as dynamic?,
        score: score == dimmutable ? _value.score : score as dynamic?,
        completed:
            completed == dimmutable ? _value.completed : completed as bool?,
        datePublished: datePublished == dimmutable
            ? _value.datePublished
            : datePublished as dynamic?,
        has: has == dimmutable ? _value.has : has as dynamic?,
        and: and == dimmutable ? _value.and : and as List<dynamic?>?,
        or: or == dimmutable ? _value.or : or as List<dynamic?>?,
        not: not == dimmutable ? _value.not : not as dynamic?));
  }
}

abstract class _$PostFilterCopyWith<O> implements $PostFilterCopyWith<O> {
  factory _$PostFilterCopyWith(PostFilter value, O Function(PostFilter) then) =
      __$PostFilterCopyWithImpl<O>;
  O call(
      {List<String>? id,
      dynamic? title,
      dynamic? score,
      bool? completed,
      dynamic? datePublished,
      dynamic? has,
      List<dynamic?>? and,
      List<dynamic?>? or,
      dynamic? not});
}

class __$PostFilterCopyWithImpl<O> extends _$PostFilterCopyWithImpl<O>
    implements _$PostFilterCopyWith<O> {
  __$PostFilterCopyWithImpl(PostFilter _value, O Function(PostFilter) _then)
      : super(_value, (v) => _then(v));

  @override
  PostFilter get _value => super._value;

  @override
  O call(
      {Object? id = dimmutable,
      Object? title = dimmutable,
      Object? score = dimmutable,
      Object? completed = dimmutable,
      Object? datePublished = dimmutable,
      Object? has = dimmutable,
      Object? and = dimmutable,
      Object? or = dimmutable,
      Object? not = dimmutable}) {
    return _then(PostFilter(
        id: id == dimmutable ? _value.id : id as List<String>?,
        title: title == dimmutable ? _value.title : title as dynamic?,
        score: score == dimmutable ? _value.score : score as dynamic?,
        completed:
            completed == dimmutable ? _value.completed : completed as bool?,
        datePublished: datePublished == dimmutable
            ? _value.datePublished
            : datePublished as dynamic?,
        has: has == dimmutable ? _value.has : has as dynamic?,
        and: and == dimmutable ? _value.and : and as List<dynamic?>?,
        or: or == dimmutable ? _value.or : or as List<dynamic?>?,
        not: not == dimmutable ? _value.not : not as dynamic?));
  }
}

@JsonSerializable()
class TaskRef {
  final String? id;

  final String? title;

  final bool? completed;

  final dynamic? user;

  @JsonKey(ignore: true)
  _$TaskRefCopyWith<TaskRef> get copyWith =>
      __$TaskRefCopyWithImpl<TaskRef>(this, IdentityFn);

  const TaskRef({this.id, this.title, this.completed, this.user});

  factory TaskRef.fromJson(Map<String, dynamic> json) =>
      _$TaskRefFromJson(json);

  Map<String, dynamic> toJson() => _$TaskRefToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is TaskRef &&
        o.id == id &&
        o.title == title &&
        o.completed == completed &&
        o.user == user;
  }

  @override
  int get hashCode =>
      id.hashCode ^ title.hashCode ^ completed.hashCode ^ user.hashCode;

  @override
  String toString() =>
      "TaskRef(id: ${this.id}, title: ${this.title}, completed: ${this.completed}, user: ${this.user})";
}

abstract class $TaskRefCopyWith<O> {
  factory $TaskRefCopyWith(TaskRef value, O Function(TaskRef) then) =
      _$TaskRefCopyWithImpl<O>;
  O call({String? id, String? title, bool? completed, dynamic? user});
}

class _$TaskRefCopyWithImpl<O> implements $TaskRefCopyWith<O> {
  final TaskRef _value;
  final O Function(TaskRef) _then;
  _$TaskRefCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? id = dimmutable,
      Object? title = dimmutable,
      Object? completed = dimmutable,
      Object? user = dimmutable}) {
    return _then(_value.copyWith(
        id: id == dimmutable ? _value.id : id as String?,
        title: title == dimmutable ? _value.title : title as String?,
        completed:
            completed == dimmutable ? _value.completed : completed as bool?,
        user: user == dimmutable ? _value.user : user as dynamic?));
  }
}

abstract class _$TaskRefCopyWith<O> implements $TaskRefCopyWith<O> {
  factory _$TaskRefCopyWith(TaskRef value, O Function(TaskRef) then) =
      __$TaskRefCopyWithImpl<O>;
  O call({String? id, String? title, bool? completed, dynamic? user});
}

class __$TaskRefCopyWithImpl<O> extends _$TaskRefCopyWithImpl<O>
    implements _$TaskRefCopyWith<O> {
  __$TaskRefCopyWithImpl(TaskRef _value, O Function(TaskRef) _then)
      : super(_value, (v) => _then(v));

  @override
  TaskRef get _value => super._value;

  @override
  O call(
      {Object? id = dimmutable,
      Object? title = dimmutable,
      Object? completed = dimmutable,
      Object? user = dimmutable}) {
    return _then(TaskRef(
        id: id == dimmutable ? _value.id : id as String?,
        title: title == dimmutable ? _value.title : title as String?,
        completed:
            completed == dimmutable ? _value.completed : completed as bool?,
        user: user == dimmutable ? _value.user : user as dynamic?));
  }
}

@JsonSerializable()
class Int64Filter {
  final int? eq;

  final int? le;

  final int? lt;

  final int? ge;

  final int? gt;

  final dynamic? between;

  @JsonKey(ignore: true)
  _$Int64FilterCopyWith<Int64Filter> get copyWith =>
      __$Int64FilterCopyWithImpl<Int64Filter>(this, IdentityFn);

  const Int64Filter(
      {this.eq, this.le, this.lt, this.ge, this.gt, this.between});

  factory Int64Filter.fromJson(Map<String, dynamic> json) =>
      _$Int64FilterFromJson(json);

  Map<String, dynamic> toJson() => _$Int64FilterToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is Int64Filter &&
        o.eq == eq &&
        o.le == le &&
        o.lt == lt &&
        o.ge == ge &&
        o.gt == gt &&
        o.between == between;
  }

  @override
  int get hashCode =>
      eq.hashCode ^
      le.hashCode ^
      lt.hashCode ^
      ge.hashCode ^
      gt.hashCode ^
      between.hashCode;

  @override
  String toString() =>
      "Int64Filter(eq: ${this.eq}, le: ${this.le}, lt: ${this.lt}, ge: ${this.ge}, gt: ${this.gt}, between: ${this.between})";
}

abstract class $Int64FilterCopyWith<O> {
  factory $Int64FilterCopyWith(
          Int64Filter value, O Function(Int64Filter) then) =
      _$Int64FilterCopyWithImpl<O>;
  O call({int? eq, int? le, int? lt, int? ge, int? gt, dynamic? between});
}

class _$Int64FilterCopyWithImpl<O> implements $Int64FilterCopyWith<O> {
  final Int64Filter _value;
  final O Function(Int64Filter) _then;
  _$Int64FilterCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? eq = dimmutable,
      Object? le = dimmutable,
      Object? lt = dimmutable,
      Object? ge = dimmutable,
      Object? gt = dimmutable,
      Object? between = dimmutable}) {
    return _then(_value.copyWith(
        eq: eq == dimmutable ? _value.eq : eq as int?,
        le: le == dimmutable ? _value.le : le as int?,
        lt: lt == dimmutable ? _value.lt : lt as int?,
        ge: ge == dimmutable ? _value.ge : ge as int?,
        gt: gt == dimmutable ? _value.gt : gt as int?,
        between: between == dimmutable ? _value.between : between as dynamic?));
  }
}

abstract class _$Int64FilterCopyWith<O> implements $Int64FilterCopyWith<O> {
  factory _$Int64FilterCopyWith(
          Int64Filter value, O Function(Int64Filter) then) =
      __$Int64FilterCopyWithImpl<O>;
  O call({int? eq, int? le, int? lt, int? ge, int? gt, dynamic? between});
}

class __$Int64FilterCopyWithImpl<O> extends _$Int64FilterCopyWithImpl<O>
    implements _$Int64FilterCopyWith<O> {
  __$Int64FilterCopyWithImpl(Int64Filter _value, O Function(Int64Filter) _then)
      : super(_value, (v) => _then(v));

  @override
  Int64Filter get _value => super._value;

  @override
  O call(
      {Object? eq = dimmutable,
      Object? le = dimmutable,
      Object? lt = dimmutable,
      Object? ge = dimmutable,
      Object? gt = dimmutable,
      Object? between = dimmutable}) {
    return _then(Int64Filter(
        eq: eq == dimmutable ? _value.eq : eq as int?,
        le: le == dimmutable ? _value.le : le as int?,
        lt: lt == dimmutable ? _value.lt : lt as int?,
        ge: ge == dimmutable ? _value.ge : ge as int?,
        gt: gt == dimmutable ? _value.gt : gt as int?,
        between: between == dimmutable ? _value.between : between as dynamic?));
  }
}

@JsonSerializable()
class UpdateUserInput {
  final dynamic filter;

  final dynamic? set;

  final dynamic? remove;

  @JsonKey(ignore: true)
  _$UpdateUserInputCopyWith<UpdateUserInput> get copyWith =>
      __$UpdateUserInputCopyWithImpl<UpdateUserInput>(this, IdentityFn);

  const UpdateUserInput({required this.filter, this.set, this.remove});

  factory UpdateUserInput.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserInputFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserInputToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is UpdateUserInput &&
        o.filter == filter &&
        o.set == set &&
        o.remove == remove;
  }

  @override
  int get hashCode => filter.hashCode ^ set.hashCode ^ remove.hashCode;

  @override
  String toString() =>
      "UpdateUserInput(filter: ${this.filter}, set: ${this.set}, remove: ${this.remove})";
}

abstract class $UpdateUserInputCopyWith<O> {
  factory $UpdateUserInputCopyWith(
          UpdateUserInput value, O Function(UpdateUserInput) then) =
      _$UpdateUserInputCopyWithImpl<O>;
  O call({dynamic filter, dynamic? set, dynamic? remove});
}

class _$UpdateUserInputCopyWithImpl<O> implements $UpdateUserInputCopyWith<O> {
  final UpdateUserInput _value;
  final O Function(UpdateUserInput) _then;
  _$UpdateUserInputCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? filter = dimmutable,
      Object? set = dimmutable,
      Object? remove = dimmutable}) {
    return _then(_value.copyWith(
        filter: filter == dimmutable ? _value.filter : filter as dynamic,
        set: set == dimmutable ? _value.set : set as dynamic?,
        remove: remove == dimmutable ? _value.remove : remove as dynamic?));
  }
}

abstract class _$UpdateUserInputCopyWith<O>
    implements $UpdateUserInputCopyWith<O> {
  factory _$UpdateUserInputCopyWith(
          UpdateUserInput value, O Function(UpdateUserInput) then) =
      __$UpdateUserInputCopyWithImpl<O>;
  O call({dynamic filter, dynamic? set, dynamic? remove});
}

class __$UpdateUserInputCopyWithImpl<O> extends _$UpdateUserInputCopyWithImpl<O>
    implements _$UpdateUserInputCopyWith<O> {
  __$UpdateUserInputCopyWithImpl(
      UpdateUserInput _value, O Function(UpdateUserInput) _then)
      : super(_value, (v) => _then(v));

  @override
  UpdateUserInput get _value => super._value;

  @override
  O call(
      {Object? filter = dimmutable,
      Object? set = dimmutable,
      Object? remove = dimmutable}) {
    return _then(UpdateUserInput(
        filter: filter == dimmutable ? _value.filter : filter as dynamic,
        set: set == dimmutable ? _value.set : set as dynamic?,
        remove: remove == dimmutable ? _value.remove : remove as dynamic?));
  }
}

@JsonSerializable()
class DateTimeFilter {
  final dynamic? eq;

  final dynamic? le;

  final dynamic? lt;

  final dynamic? ge;

  final dynamic? gt;

  final dynamic? between;

  @JsonKey(ignore: true)
  _$DateTimeFilterCopyWith<DateTimeFilter> get copyWith =>
      __$DateTimeFilterCopyWithImpl<DateTimeFilter>(this, IdentityFn);

  const DateTimeFilter(
      {this.eq, this.le, this.lt, this.ge, this.gt, this.between});

  factory DateTimeFilter.fromJson(Map<String, dynamic> json) =>
      _$DateTimeFilterFromJson(json);

  Map<String, dynamic> toJson() => _$DateTimeFilterToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is DateTimeFilter &&
        o.eq == eq &&
        o.le == le &&
        o.lt == lt &&
        o.ge == ge &&
        o.gt == gt &&
        o.between == between;
  }

  @override
  int get hashCode =>
      eq.hashCode ^
      le.hashCode ^
      lt.hashCode ^
      ge.hashCode ^
      gt.hashCode ^
      between.hashCode;

  @override
  String toString() =>
      "DateTimeFilter(eq: ${this.eq}, le: ${this.le}, lt: ${this.lt}, ge: ${this.ge}, gt: ${this.gt}, between: ${this.between})";
}

abstract class $DateTimeFilterCopyWith<O> {
  factory $DateTimeFilterCopyWith(
          DateTimeFilter value, O Function(DateTimeFilter) then) =
      _$DateTimeFilterCopyWithImpl<O>;
  O call(
      {dynamic? eq,
      dynamic? le,
      dynamic? lt,
      dynamic? ge,
      dynamic? gt,
      dynamic? between});
}

class _$DateTimeFilterCopyWithImpl<O> implements $DateTimeFilterCopyWith<O> {
  final DateTimeFilter _value;
  final O Function(DateTimeFilter) _then;
  _$DateTimeFilterCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? eq = dimmutable,
      Object? le = dimmutable,
      Object? lt = dimmutable,
      Object? ge = dimmutable,
      Object? gt = dimmutable,
      Object? between = dimmutable}) {
    return _then(_value.copyWith(
        eq: eq == dimmutable ? _value.eq : eq as dynamic?,
        le: le == dimmutable ? _value.le : le as dynamic?,
        lt: lt == dimmutable ? _value.lt : lt as dynamic?,
        ge: ge == dimmutable ? _value.ge : ge as dynamic?,
        gt: gt == dimmutable ? _value.gt : gt as dynamic?,
        between: between == dimmutable ? _value.between : between as dynamic?));
  }
}

abstract class _$DateTimeFilterCopyWith<O>
    implements $DateTimeFilterCopyWith<O> {
  factory _$DateTimeFilterCopyWith(
          DateTimeFilter value, O Function(DateTimeFilter) then) =
      __$DateTimeFilterCopyWithImpl<O>;
  O call(
      {dynamic? eq,
      dynamic? le,
      dynamic? lt,
      dynamic? ge,
      dynamic? gt,
      dynamic? between});
}

class __$DateTimeFilterCopyWithImpl<O> extends _$DateTimeFilterCopyWithImpl<O>
    implements _$DateTimeFilterCopyWith<O> {
  __$DateTimeFilterCopyWithImpl(
      DateTimeFilter _value, O Function(DateTimeFilter) _then)
      : super(_value, (v) => _then(v));

  @override
  DateTimeFilter get _value => super._value;

  @override
  O call(
      {Object? eq = dimmutable,
      Object? le = dimmutable,
      Object? lt = dimmutable,
      Object? ge = dimmutable,
      Object? gt = dimmutable,
      Object? between = dimmutable}) {
    return _then(DateTimeFilter(
        eq: eq == dimmutable ? _value.eq : eq as dynamic?,
        le: le == dimmutable ? _value.le : le as dynamic?,
        lt: lt == dimmutable ? _value.lt : lt as dynamic?,
        ge: ge == dimmutable ? _value.ge : ge as dynamic?,
        gt: gt == dimmutable ? _value.gt : gt as dynamic?,
        between: between == dimmutable ? _value.between : between as dynamic?));
  }
}

@JsonSerializable()
class AuthorFilter {
  final List<String>? id;

  final dynamic? name;

  final dynamic? has;

  final List<dynamic?>? and;

  final List<dynamic?>? or;

  final dynamic? not;

  @JsonKey(ignore: true)
  _$AuthorFilterCopyWith<AuthorFilter> get copyWith =>
      __$AuthorFilterCopyWithImpl<AuthorFilter>(this, IdentityFn);

  const AuthorFilter(
      {this.id, this.name, this.has, this.and, this.or, this.not});

  factory AuthorFilter.fromJson(Map<String, dynamic> json) =>
      _$AuthorFilterFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorFilterToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is AuthorFilter &&
        o.id == id &&
        o.name == name &&
        o.has == has &&
        o.and == and &&
        o.or == or &&
        o.not == not;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      has.hashCode ^
      and.hashCode ^
      or.hashCode ^
      not.hashCode;

  @override
  String toString() =>
      "AuthorFilter(id: ${this.id}, name: ${this.name}, has: ${this.has}, and: ${this.and}, or: ${this.or}, not: ${this.not})";
}

abstract class $AuthorFilterCopyWith<O> {
  factory $AuthorFilterCopyWith(
          AuthorFilter value, O Function(AuthorFilter) then) =
      _$AuthorFilterCopyWithImpl<O>;
  O call(
      {List<String>? id,
      dynamic? name,
      dynamic? has,
      List<dynamic?>? and,
      List<dynamic?>? or,
      dynamic? not});
}

class _$AuthorFilterCopyWithImpl<O> implements $AuthorFilterCopyWith<O> {
  final AuthorFilter _value;
  final O Function(AuthorFilter) _then;
  _$AuthorFilterCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? id = dimmutable,
      Object? name = dimmutable,
      Object? has = dimmutable,
      Object? and = dimmutable,
      Object? or = dimmutable,
      Object? not = dimmutable}) {
    return _then(_value.copyWith(
        id: id == dimmutable ? _value.id : id as List<String>?,
        name: name == dimmutable ? _value.name : name as dynamic?,
        has: has == dimmutable ? _value.has : has as dynamic?,
        and: and == dimmutable ? _value.and : and as List<dynamic?>?,
        or: or == dimmutable ? _value.or : or as List<dynamic?>?,
        not: not == dimmutable ? _value.not : not as dynamic?));
  }
}

abstract class _$AuthorFilterCopyWith<O> implements $AuthorFilterCopyWith<O> {
  factory _$AuthorFilterCopyWith(
          AuthorFilter value, O Function(AuthorFilter) then) =
      __$AuthorFilterCopyWithImpl<O>;
  O call(
      {List<String>? id,
      dynamic? name,
      dynamic? has,
      List<dynamic?>? and,
      List<dynamic?>? or,
      dynamic? not});
}

class __$AuthorFilterCopyWithImpl<O> extends _$AuthorFilterCopyWithImpl<O>
    implements _$AuthorFilterCopyWith<O> {
  __$AuthorFilterCopyWithImpl(
      AuthorFilter _value, O Function(AuthorFilter) _then)
      : super(_value, (v) => _then(v));

  @override
  AuthorFilter get _value => super._value;

  @override
  O call(
      {Object? id = dimmutable,
      Object? name = dimmutable,
      Object? has = dimmutable,
      Object? and = dimmutable,
      Object? or = dimmutable,
      Object? not = dimmutable}) {
    return _then(AuthorFilter(
        id: id == dimmutable ? _value.id : id as List<String>?,
        name: name == dimmutable ? _value.name : name as dynamic?,
        has: has == dimmutable ? _value.has : has as dynamic?,
        and: and == dimmutable ? _value.and : and as List<dynamic?>?,
        or: or == dimmutable ? _value.or : or as List<dynamic?>?,
        not: not == dimmutable ? _value.not : not as dynamic?));
  }
}

@JsonSerializable()
class PostRef {
  final String? id;

  final String? title;

  final String? text;

  final double? score;

  final bool? completed;

  final dynamic? datePublished;

  final dynamic? author;

  @JsonKey(ignore: true)
  _$PostRefCopyWith<PostRef> get copyWith =>
      __$PostRefCopyWithImpl<PostRef>(this, IdentityFn);

  const PostRef(
      {this.id,
      this.title,
      this.text,
      this.score,
      this.completed,
      this.datePublished,
      this.author});

  factory PostRef.fromJson(Map<String, dynamic> json) =>
      _$PostRefFromJson(json);

  Map<String, dynamic> toJson() => _$PostRefToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is PostRef &&
        o.id == id &&
        o.title == title &&
        o.text == text &&
        o.score == score &&
        o.completed == completed &&
        o.datePublished == datePublished &&
        o.author == author;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      text.hashCode ^
      score.hashCode ^
      completed.hashCode ^
      datePublished.hashCode ^
      author.hashCode;

  @override
  String toString() =>
      "PostRef(id: ${this.id}, title: ${this.title}, text: ${this.text}, score: ${this.score}, completed: ${this.completed}, datePublished: ${this.datePublished}, author: ${this.author})";
}

abstract class $PostRefCopyWith<O> {
  factory $PostRefCopyWith(PostRef value, O Function(PostRef) then) =
      _$PostRefCopyWithImpl<O>;
  O call(
      {String? id,
      String? title,
      String? text,
      double? score,
      bool? completed,
      dynamic? datePublished,
      dynamic? author});
}

class _$PostRefCopyWithImpl<O> implements $PostRefCopyWith<O> {
  final PostRef _value;
  final O Function(PostRef) _then;
  _$PostRefCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? id = dimmutable,
      Object? title = dimmutable,
      Object? text = dimmutable,
      Object? score = dimmutable,
      Object? completed = dimmutable,
      Object? datePublished = dimmutable,
      Object? author = dimmutable}) {
    return _then(_value.copyWith(
        id: id == dimmutable ? _value.id : id as String?,
        title: title == dimmutable ? _value.title : title as String?,
        text: text == dimmutable ? _value.text : text as String?,
        score: score == dimmutable ? _value.score : score as double?,
        completed:
            completed == dimmutable ? _value.completed : completed as bool?,
        datePublished: datePublished == dimmutable
            ? _value.datePublished
            : datePublished as dynamic?,
        author: author == dimmutable ? _value.author : author as dynamic?));
  }
}

abstract class _$PostRefCopyWith<O> implements $PostRefCopyWith<O> {
  factory _$PostRefCopyWith(PostRef value, O Function(PostRef) then) =
      __$PostRefCopyWithImpl<O>;
  O call(
      {String? id,
      String? title,
      String? text,
      double? score,
      bool? completed,
      dynamic? datePublished,
      dynamic? author});
}

class __$PostRefCopyWithImpl<O> extends _$PostRefCopyWithImpl<O>
    implements _$PostRefCopyWith<O> {
  __$PostRefCopyWithImpl(PostRef _value, O Function(PostRef) _then)
      : super(_value, (v) => _then(v));

  @override
  PostRef get _value => super._value;

  @override
  O call(
      {Object? id = dimmutable,
      Object? title = dimmutable,
      Object? text = dimmutable,
      Object? score = dimmutable,
      Object? completed = dimmutable,
      Object? datePublished = dimmutable,
      Object? author = dimmutable}) {
    return _then(PostRef(
        id: id == dimmutable ? _value.id : id as String?,
        title: title == dimmutable ? _value.title : title as String?,
        text: text == dimmutable ? _value.text : text as String?,
        score: score == dimmutable ? _value.score : score as double?,
        completed:
            completed == dimmutable ? _value.completed : completed as bool?,
        datePublished: datePublished == dimmutable
            ? _value.datePublished
            : datePublished as dynamic?,
        author: author == dimmutable ? _value.author : author as dynamic?));
  }
}

@JsonSerializable()
class StringExactFilter {
  final String? eq;

  final List<String?>? d_in;

  final String? le;

  final String? lt;

  final String? ge;

  final String? gt;

  final dynamic? between;

  @JsonKey(ignore: true)
  _$StringExactFilterCopyWith<StringExactFilter> get copyWith =>
      __$StringExactFilterCopyWithImpl<StringExactFilter>(this, IdentityFn);

  const StringExactFilter(
      {this.eq, this.d_in, this.le, this.lt, this.ge, this.gt, this.between});

  factory StringExactFilter.fromJson(Map<String, dynamic> json) =>
      _$StringExactFilterFromJson(json);

  Map<String, dynamic> toJson() => _$StringExactFilterToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is StringExactFilter &&
        o.eq == eq &&
        o.d_in == d_in &&
        o.le == le &&
        o.lt == lt &&
        o.ge == ge &&
        o.gt == gt &&
        o.between == between;
  }

  @override
  int get hashCode =>
      eq.hashCode ^
      d_in.hashCode ^
      le.hashCode ^
      lt.hashCode ^
      ge.hashCode ^
      gt.hashCode ^
      between.hashCode;

  @override
  String toString() =>
      "StringExactFilter(eq: ${this.eq}, d_in: ${this.d_in}, le: ${this.le}, lt: ${this.lt}, ge: ${this.ge}, gt: ${this.gt}, between: ${this.between})";
}

abstract class $StringExactFilterCopyWith<O> {
  factory $StringExactFilterCopyWith(
          StringExactFilter value, O Function(StringExactFilter) then) =
      _$StringExactFilterCopyWithImpl<O>;
  O call(
      {String? eq,
      List<String?>? d_in,
      String? le,
      String? lt,
      String? ge,
      String? gt,
      dynamic? between});
}

class _$StringExactFilterCopyWithImpl<O>
    implements $StringExactFilterCopyWith<O> {
  final StringExactFilter _value;
  final O Function(StringExactFilter) _then;
  _$StringExactFilterCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? eq = dimmutable,
      Object? d_in = dimmutable,
      Object? le = dimmutable,
      Object? lt = dimmutable,
      Object? ge = dimmutable,
      Object? gt = dimmutable,
      Object? between = dimmutable}) {
    return _then(_value.copyWith(
        eq: eq == dimmutable ? _value.eq : eq as String?,
        d_in: d_in == dimmutable ? _value.d_in : d_in as List<String?>?,
        le: le == dimmutable ? _value.le : le as String?,
        lt: lt == dimmutable ? _value.lt : lt as String?,
        ge: ge == dimmutable ? _value.ge : ge as String?,
        gt: gt == dimmutable ? _value.gt : gt as String?,
        between: between == dimmutable ? _value.between : between as dynamic?));
  }
}

abstract class _$StringExactFilterCopyWith<O>
    implements $StringExactFilterCopyWith<O> {
  factory _$StringExactFilterCopyWith(
          StringExactFilter value, O Function(StringExactFilter) then) =
      __$StringExactFilterCopyWithImpl<O>;
  O call(
      {String? eq,
      List<String?>? d_in,
      String? le,
      String? lt,
      String? ge,
      String? gt,
      dynamic? between});
}

class __$StringExactFilterCopyWithImpl<O>
    extends _$StringExactFilterCopyWithImpl<O>
    implements _$StringExactFilterCopyWith<O> {
  __$StringExactFilterCopyWithImpl(
      StringExactFilter _value, O Function(StringExactFilter) _then)
      : super(_value, (v) => _then(v));

  @override
  StringExactFilter get _value => super._value;

  @override
  O call(
      {Object? eq = dimmutable,
      Object? d_in = dimmutable,
      Object? le = dimmutable,
      Object? lt = dimmutable,
      Object? ge = dimmutable,
      Object? gt = dimmutable,
      Object? between = dimmutable}) {
    return _then(StringExactFilter(
        eq: eq == dimmutable ? _value.eq : eq as String?,
        d_in: d_in == dimmutable ? _value.d_in : d_in as List<String?>?,
        le: le == dimmutable ? _value.le : le as String?,
        lt: lt == dimmutable ? _value.lt : lt as String?,
        ge: ge == dimmutable ? _value.ge : ge as String?,
        gt: gt == dimmutable ? _value.gt : gt as String?,
        between: between == dimmutable ? _value.between : between as dynamic?));
  }
}

@JsonSerializable()
class UserOrder {
  final dynamic? asc;

  final dynamic? desc;

  final dynamic? then;

  @JsonKey(ignore: true)
  _$UserOrderCopyWith<UserOrder> get copyWith =>
      __$UserOrderCopyWithImpl<UserOrder>(this, IdentityFn);

  const UserOrder({this.asc, this.desc, this.then});

  factory UserOrder.fromJson(Map<String, dynamic> json) =>
      _$UserOrderFromJson(json);

  Map<String, dynamic> toJson() => _$UserOrderToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is UserOrder && o.asc == asc && o.desc == desc && o.then == then;
  }

  @override
  int get hashCode => asc.hashCode ^ desc.hashCode ^ then.hashCode;

  @override
  String toString() =>
      "UserOrder(asc: ${this.asc}, desc: ${this.desc}, then: ${this.then})";
}

abstract class $UserOrderCopyWith<O> {
  factory $UserOrderCopyWith(UserOrder value, O Function(UserOrder) then) =
      _$UserOrderCopyWithImpl<O>;
  O call({dynamic? asc, dynamic? desc, dynamic? then});
}

class _$UserOrderCopyWithImpl<O> implements $UserOrderCopyWith<O> {
  final UserOrder _value;
  final O Function(UserOrder) _then;
  _$UserOrderCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? asc = dimmutable,
      Object? desc = dimmutable,
      Object? then = dimmutable}) {
    return _then(_value.copyWith(
        asc: asc == dimmutable ? _value.asc : asc as dynamic?,
        desc: desc == dimmutable ? _value.desc : desc as dynamic?,
        then: then == dimmutable ? _value.then : then as dynamic?));
  }
}

abstract class _$UserOrderCopyWith<O> implements $UserOrderCopyWith<O> {
  factory _$UserOrderCopyWith(UserOrder value, O Function(UserOrder) then) =
      __$UserOrderCopyWithImpl<O>;
  O call({dynamic? asc, dynamic? desc, dynamic? then});
}

class __$UserOrderCopyWithImpl<O> extends _$UserOrderCopyWithImpl<O>
    implements _$UserOrderCopyWith<O> {
  __$UserOrderCopyWithImpl(UserOrder _value, O Function(UserOrder) _then)
      : super(_value, (v) => _then(v));

  @override
  UserOrder get _value => super._value;

  @override
  O call(
      {Object? asc = dimmutable,
      Object? desc = dimmutable,
      Object? then = dimmutable}) {
    return _then(UserOrder(
        asc: asc == dimmutable ? _value.asc : asc as dynamic?,
        desc: desc == dimmutable ? _value.desc : desc as dynamic?,
        then: then == dimmutable ? _value.then : then as dynamic?));
  }
}

class __EnumValue {
  void name({String? alias, String? directive}) {}
  void description({String? alias, String? directive}) {}
  void isDeprecated({String? alias, String? directive}) {}
  void deprecationReason({String? alias, String? directive}) {}
  void d__typename;
}

class __Directive {
  void name({String? alias, String? directive}) {}
  void description({String? alias, String? directive}) {}
  void locations(__DirectiveLocation locations,
      {String? alias, String? directive}) {}
  void args(__InputValue args, {String? alias, String? directive}) {}
  void d__typename;
}

class __Type {
  void kind(__TypeKind kind, {String? alias, String? directive}) {}
  void name({String? alias, String? directive}) {}
  void description({String? alias, String? directive}) {}
  void fields(__Field fields,
      {String? includeDeprecated, String? alias, String? directive}) {}
  void interfaces(__Type interfaces, {String? alias, String? directive}) {}
  void possibleTypes(__Type possibleTypes,
      {String? alias, String? directive}) {}
  void enumValues(__EnumValue enumValues,
      {String? includeDeprecated, String? alias, String? directive}) {}
  void inputFields(__InputValue inputFields,
      {String? alias, String? directive}) {}
  void ofType(__Type ofType, {String? alias, String? directive}) {}
  void d__typename;
}

class Polygon {
  void coordinates(PointList coordinates, {String? alias, String? directive}) {}
  void d__typename;
}

class UpdateAuthorPayload {
  void author(Author author,
      {String? filter,
      String? order,
      String? first,
      String? offset,
      String? alias,
      String? directive}) {}
  void numUids({String? alias, String? directive}) {}
  void d__typename;
}

class PointList {
  void points(Point points, {String? alias, String? directive}) {}
  void d__typename;
}

class AddAuthorPayload {
  void author(Author author,
      {String? filter,
      String? order,
      String? first,
      String? offset,
      String? alias,
      String? directive}) {}
  void numUids({String? alias, String? directive}) {}
  void d__typename;
}

class User {
  void username({String? alias, String? directive}) {}
  void name({String? alias, String? directive}) {}
  void tasks(Task tasks,
      {String? filter,
      String? order,
      String? first,
      String? offset,
      String? alias,
      String? directive}) {}
  void tasksAggregate(TaskAggregateResult tasksAggregate,
      {String? filter, String? alias, String? directive}) {}
  void d__typename;
}

class DeletePostPayload {
  void post(Post post,
      {String? filter,
      String? order,
      String? first,
      String? offset,
      String? alias,
      String? directive}) {}
  void msg({String? alias, String? directive}) {}
  void numUids({String? alias, String? directive}) {}
  void d__typename;
}

class DeleteUserPayload {
  void user(User user,
      {String? filter,
      String? order,
      String? first,
      String? offset,
      String? alias,
      String? directive}) {}
  void msg({String? alias, String? directive}) {}
  void numUids({String? alias, String? directive}) {}
  void d__typename;
}

class TaskAggregateResult {
  void count({String? alias, String? directive}) {}
  void titleMin({String? alias, String? directive}) {}
  void titleMax({String? alias, String? directive}) {}
  void d__typename;
}

class DeleteAuthorPayload {
  void author(Author author,
      {String? filter,
      String? order,
      String? first,
      String? offset,
      String? alias,
      String? directive}) {}
  void msg({String? alias, String? directive}) {}
  void numUids({String? alias, String? directive}) {}
  void d__typename;
}

class MultiPolygon {
  void polygons(Polygon polygons, {String? alias, String? directive}) {}
  void d__typename;
}

class Mutation {
  Mutation([String? args]);
  void addPost(AddPostPayload addPost,
      {String? input, String? alias, String? directive}) {}
  void updatePost(UpdatePostPayload updatePost,
      {String? input, String? alias, String? directive}) {}
  void deletePost(DeletePostPayload deletePost,
      {String? filter, String? alias, String? directive}) {}
  void addAuthor(AddAuthorPayload addAuthor,
      {String? input, String? alias, String? directive}) {}
  void updateAuthor(UpdateAuthorPayload updateAuthor,
      {String? input, String? alias, String? directive}) {}
  void deleteAuthor(DeleteAuthorPayload deleteAuthor,
      {String? filter, String? alias, String? directive}) {}
  void addTask(AddTaskPayload addTask,
      {String? input, String? alias, String? directive}) {}
  void updateTask(UpdateTaskPayload updateTask,
      {String? input, String? alias, String? directive}) {}
  void deleteTask(DeleteTaskPayload deleteTask,
      {String? filter, String? alias, String? directive}) {}
  void addUser(AddUserPayload addUser,
      {String? input, String? alias, String? directive}) {}
  void updateUser(UpdateUserPayload updateUser,
      {String? input, String? alias, String? directive}) {}
  void deleteUser(DeleteUserPayload deleteUser,
      {String? filter, String? alias, String? directive}) {}
  void d__typename;
}

class AddTaskPayload {
  void task(Task task,
      {String? filter,
      String? order,
      String? first,
      String? offset,
      String? alias,
      String? directive}) {}
  void numUids({String? alias, String? directive}) {}
  void d__typename;
}

class __Schema {
  void types(__Type types, {String? alias, String? directive}) {}
  void queryType(__Type queryType, {String? alias, String? directive}) {}
  void mutationType(__Type mutationType, {String? alias, String? directive}) {}
  void subscriptionType(__Type subscriptionType,
      {String? alias, String? directive}) {}
  void directives(__Directive directives, {String? alias, String? directive}) {}
  void d__typename;
}

class Point {
  void longitude({String? alias, String? directive}) {}
  void latitude({String? alias, String? directive}) {}
  void d__typename;
}

class AddPostPayload {
  void post(Post post,
      {String? filter,
      String? order,
      String? first,
      String? offset,
      String? alias,
      String? directive}) {}
  void numUids({String? alias, String? directive}) {}
  void d__typename;
}

class UserAggregateResult {
  void count({String? alias, String? directive}) {}
  void usernameMin({String? alias, String? directive}) {}
  void usernameMax({String? alias, String? directive}) {}
  void nameMin({String? alias, String? directive}) {}
  void nameMax({String? alias, String? directive}) {}
  void d__typename;
}

class Post {
  void id({String? alias, String? directive}) {}
  void title({String? alias, String? directive}) {}
  void text({String? alias, String? directive}) {}
  void score({String? alias, String? directive}) {}
  void completed({String? alias, String? directive}) {}
  void datePublished({String? alias, String? directive}) {}
  void author(Author author,
      {String? filter, String? alias, String? directive}) {}
  void d__typename;
}

class UpdateTaskPayload {
  void task(Task task,
      {String? filter,
      String? order,
      String? first,
      String? offset,
      String? alias,
      String? directive}) {}
  void numUids({String? alias, String? directive}) {}
  void d__typename;
}

class DeleteTaskPayload {
  void task(Task task,
      {String? filter,
      String? order,
      String? first,
      String? offset,
      String? alias,
      String? directive}) {}
  void msg({String? alias, String? directive}) {}
  void numUids({String? alias, String? directive}) {}
  void d__typename;
}

class PostAggregateResult {
  void count({String? alias, String? directive}) {}
  void titleMin({String? alias, String? directive}) {}
  void titleMax({String? alias, String? directive}) {}
  void textMin({String? alias, String? directive}) {}
  void textMax({String? alias, String? directive}) {}
  void scoreMin({String? alias, String? directive}) {}
  void scoreMax({String? alias, String? directive}) {}
  void scoreSum({String? alias, String? directive}) {}
  void scoreAvg({String? alias, String? directive}) {}
  void datePublishedMin({String? alias, String? directive}) {}
  void datePublishedMax({String? alias, String? directive}) {}
  void d__typename;
}

class UpdatePostPayload {
  void post(Post post,
      {String? filter,
      String? order,
      String? first,
      String? offset,
      String? alias,
      String? directive}) {}
  void numUids({String? alias, String? directive}) {}
  void d__typename;
}

class UpdateUserPayload {
  void user(User user,
      {String? filter,
      String? order,
      String? first,
      String? offset,
      String? alias,
      String? directive}) {}
  void numUids({String? alias, String? directive}) {}
  void d__typename;
}

class __InputValue {
  void name({String? alias, String? directive}) {}
  void description({String? alias, String? directive}) {}
  void type(__Type type, {String? alias, String? directive}) {}
  void defaultValue({String? alias, String? directive}) {}
  void d__typename;
}

class Task {
  void id({String? alias, String? directive}) {}
  void title({String? alias, String? directive}) {}
  void completed({String? alias, String? directive}) {}
  void user(User user, {String? filter, String? alias, String? directive}) {}
  void d__typename;
}

class AddUserPayload {
  void user(User user,
      {String? filter,
      String? order,
      String? first,
      String? offset,
      String? alias,
      String? directive}) {}
  void numUids({String? alias, String? directive}) {}
  void d__typename;
}

class __Field {
  void name({String? alias, String? directive}) {}
  void description({String? alias, String? directive}) {}
  void args(__InputValue args, {String? alias, String? directive}) {}
  void type(__Type type, {String? alias, String? directive}) {}
  void isDeprecated({String? alias, String? directive}) {}
  void deprecationReason({String? alias, String? directive}) {}
  void d__typename;
}

class Author {
  void id({String? alias, String? directive}) {}
  void name({String? alias, String? directive}) {}
  void posts(Post posts,
      {String? filter,
      String? order,
      String? first,
      String? offset,
      String? alias,
      String? directive}) {}
  void friends(Author friends,
      {String? filter,
      String? order,
      String? first,
      String? offset,
      String? alias,
      String? directive}) {}
  void n({String? alias, String? directive}) {}
  void postsAggregate(PostAggregateResult postsAggregate,
      {String? filter, String? alias, String? directive}) {}
  void friendsAggregate(AuthorAggregateResult friendsAggregate,
      {String? filter, String? alias, String? directive}) {}
  void d__typename;
}

class AuthorAggregateResult {
  void count({String? alias, String? directive}) {}
  void nameMin({String? alias, String? directive}) {}
  void nameMax({String? alias, String? directive}) {}
  void nMin({String? alias, String? directive}) {}
  void nMax({String? alias, String? directive}) {}
  void nSum({String? alias, String? directive}) {}
  void nAvg({String? alias, String? directive}) {}
  void d__typename;
}

class Query {
  Query([String? args]);
  void getPost(Post getPost, {String? id, String? alias, String? directive}) {}
  void queryPost(Post queryPost,
      {String? filter,
      String? order,
      String? first,
      String? offset,
      String? alias,
      String? directive}) {}
  void aggregatePost(PostAggregateResult aggregatePost,
      {String? filter, String? alias, String? directive}) {}
  void getAuthor(Author getAuthor,
      {String? id, String? alias, String? directive}) {}
  void queryAuthor(Author queryAuthor,
      {String? filter,
      String? order,
      String? first,
      String? offset,
      String? alias,
      String? directive}) {}
  void aggregateAuthor(AuthorAggregateResult aggregateAuthor,
      {String? filter, String? alias, String? directive}) {}
  void getTask(Task getTask, {String? id, String? alias, String? directive}) {}
  void queryTask(Task queryTask,
      {String? filter,
      String? order,
      String? first,
      String? offset,
      String? alias,
      String? directive}) {}
  void aggregateTask(TaskAggregateResult aggregateTask,
      {String? filter, String? alias, String? directive}) {}
  void getUser(User getUser,
      {String? username, String? alias, String? directive}) {}
  void queryUser(User queryUser,
      {String? filter,
      String? order,
      String? first,
      String? offset,
      String? alias,
      String? directive}) {}
  void aggregateUser(UserAggregateResult aggregateUser,
      {String? filter, String? alias, String? directive}) {}
  void d__typename;
}
