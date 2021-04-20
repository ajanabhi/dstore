// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateAuthorInput _$UpdateAuthorInputFromJson(Map<String, dynamic> json) {
  return UpdateAuthorInput(
    filter: json['filter'],
    set: json['set'],
    remove: json['remove'],
  );
}

Map<String, dynamic> _$UpdateAuthorInputToJson(UpdateAuthorInput instance) =>
    <String, dynamic>{
      'filter': instance.filter,
      'set': instance.set,
      'remove': instance.remove,
    };

AddTaskInput _$AddTaskInputFromJson(Map<String, dynamic> json) {
  return AddTaskInput(
    title: json['title'] as String,
    completed: json['completed'] as bool,
    user: json['user'],
  );
}

Map<String, dynamic> _$AddTaskInputToJson(AddTaskInput instance) =>
    <String, dynamic>{
      'title': instance.title,
      'completed': instance.completed,
      'user': instance.user,
    };

IntersectsFilter _$IntersectsFilterFromJson(Map<String, dynamic> json) {
  return IntersectsFilter(
    polygon: json['polygon'],
    multiPolygon: json['multiPolygon'],
  );
}

Map<String, dynamic> _$IntersectsFilterToJson(IntersectsFilter instance) =>
    <String, dynamic>{
      'polygon': instance.polygon,
      'multiPolygon': instance.multiPolygon,
    };

AddPostInput _$AddPostInputFromJson(Map<String, dynamic> json) {
  return AddPostInput(
    title: json['title'] as String,
    text: json['text'] as String?,
    score: (json['score'] as num?)?.toDouble(),
    completed: json['completed'] as bool?,
    datePublished: json['datePublished'],
    author: json['author'],
  );
}

Map<String, dynamic> _$AddPostInputToJson(AddPostInput instance) =>
    <String, dynamic>{
      'title': instance.title,
      'text': instance.text,
      'score': instance.score,
      'completed': instance.completed,
      'datePublished': instance.datePublished,
      'author': instance.author,
    };

AddUserInput _$AddUserInputFromJson(Map<String, dynamic> json) {
  return AddUserInput(
    username: json['username'] as String,
    name: json['name'] as String?,
    tasks: json['tasks'] as List<dynamic>?,
  );
}

Map<String, dynamic> _$AddUserInputToJson(AddUserInput instance) =>
    <String, dynamic>{
      'username': instance.username,
      'name': instance.name,
      'tasks': instance.tasks,
    };

CustomHTTP _$CustomHTTPFromJson(Map<String, dynamic> json) {
  return CustomHTTP(
    url: json['url'] as String,
    method: json['method'],
    body: json['body'] as String?,
    graphql: json['graphql'] as String?,
    mode: json['mode'],
    forwardHeaders: (json['forwardHeaders'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    secretHeaders: (json['secretHeaders'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    introspectionHeaders: (json['introspectionHeaders'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    skipIntrospection: json['skipIntrospection'] as bool?,
  );
}

Map<String, dynamic> _$CustomHTTPToJson(CustomHTTP instance) =>
    <String, dynamic>{
      'url': instance.url,
      'method': instance.method,
      'body': instance.body,
      'graphql': instance.graphql,
      'mode': instance.mode,
      'forwardHeaders': instance.forwardHeaders,
      'secretHeaders': instance.secretHeaders,
      'introspectionHeaders': instance.introspectionHeaders,
      'skipIntrospection': instance.skipIntrospection,
    };

TaskOrder _$TaskOrderFromJson(Map<String, dynamic> json) {
  return TaskOrder(
    asc: json['asc'],
    desc: json['desc'],
    then: json['then'],
  );
}

Map<String, dynamic> _$TaskOrderToJson(TaskOrder instance) => <String, dynamic>{
      'asc': instance.asc,
      'desc': instance.desc,
      'then': instance.then,
    };

PolygonGeoFilter _$PolygonGeoFilterFromJson(Map<String, dynamic> json) {
  return PolygonGeoFilter(
    near: json['near'],
    within: json['within'],
    contains: json['contains'],
    intersects: json['intersects'],
  );
}

Map<String, dynamic> _$PolygonGeoFilterToJson(PolygonGeoFilter instance) =>
    <String, dynamic>{
      'near': instance.near,
      'within': instance.within,
      'contains': instance.contains,
      'intersects': instance.intersects,
    };

GenerateQueryParams _$GenerateQueryParamsFromJson(Map<String, dynamic> json) {
  return GenerateQueryParams(
    get: json['get'] as bool?,
    query: json['query'] as bool?,
    password: json['password'] as bool?,
    aggregate: json['aggregate'] as bool?,
  );
}

Map<String, dynamic> _$GenerateQueryParamsToJson(
        GenerateQueryParams instance) =>
    <String, dynamic>{
      'get': instance.get,
      'query': instance.query,
      'password': instance.password,
      'aggregate': instance.aggregate,
    };

PostPatch _$PostPatchFromJson(Map<String, dynamic> json) {
  return PostPatch(
    title: json['title'] as String?,
    text: json['text'] as String?,
    score: (json['score'] as num?)?.toDouble(),
    completed: json['completed'] as bool?,
    datePublished: json['datePublished'],
    author: json['author'],
  );
}

Map<String, dynamic> _$PostPatchToJson(PostPatch instance) => <String, dynamic>{
      'title': instance.title,
      'text': instance.text,
      'score': instance.score,
      'completed': instance.completed,
      'datePublished': instance.datePublished,
      'author': instance.author,
    };

StringTermFilter _$StringTermFilterFromJson(Map<String, dynamic> json) {
  return StringTermFilter(
    allofterms: json['allofterms'] as String?,
    anyofterms: json['anyofterms'] as String?,
  );
}

Map<String, dynamic> _$StringTermFilterToJson(StringTermFilter instance) =>
    <String, dynamic>{
      'allofterms': instance.allofterms,
      'anyofterms': instance.anyofterms,
    };

IntFilter _$IntFilterFromJson(Map<String, dynamic> json) {
  return IntFilter(
    eq: json['eq'] as int?,
    le: json['le'] as int?,
    lt: json['lt'] as int?,
    ge: json['ge'] as int?,
    gt: json['gt'] as int?,
    between: json['between'],
  );
}

Map<String, dynamic> _$IntFilterToJson(IntFilter instance) => <String, dynamic>{
      'eq': instance.eq,
      'le': instance.le,
      'lt': instance.lt,
      'ge': instance.ge,
      'gt': instance.gt,
      'between': instance.between,
    };

AuthRule _$AuthRuleFromJson(Map<String, dynamic> json) {
  return AuthRule(
    and: json['and'] as List<dynamic>?,
    or: json['or'] as List<dynamic>?,
    not: json['not'],
    rule: json['rule'] as String?,
  );
}

Map<String, dynamic> _$AuthRuleToJson(AuthRule instance) => <String, dynamic>{
      'and': instance.and,
      'or': instance.or,
      'not': instance.not,
      'rule': instance.rule,
    };

GenerateMutationParams _$GenerateMutationParamsFromJson(
    Map<String, dynamic> json) {
  return GenerateMutationParams(
    add: json['add'] as bool?,
    update: json['update'] as bool?,
    delete: json['delete'] as bool?,
  );
}

Map<String, dynamic> _$GenerateMutationParamsToJson(
        GenerateMutationParams instance) =>
    <String, dynamic>{
      'add': instance.add,
      'update': instance.update,
      'delete': instance.delete,
    };

UserFilter _$UserFilterFromJson(Map<String, dynamic> json) {
  return UserFilter(
    username: json['username'],
    has: json['has'],
    and: json['and'] as List<dynamic>?,
    or: json['or'] as List<dynamic>?,
    not: json['not'],
  );
}

Map<String, dynamic> _$UserFilterToJson(UserFilter instance) =>
    <String, dynamic>{
      'username': instance.username,
      'has': instance.has,
      'and': instance.and,
      'or': instance.or,
      'not': instance.not,
    };

AuthorPatch _$AuthorPatchFromJson(Map<String, dynamic> json) {
  return AuthorPatch(
    name: json['name'] as String?,
    posts: json['posts'] as List<dynamic>?,
    friends: json['friends'] as List<dynamic>?,
    n: json['n'] as int?,
  );
}

Map<String, dynamic> _$AuthorPatchToJson(AuthorPatch instance) =>
    <String, dynamic>{
      'name': instance.name,
      'posts': instance.posts,
      'friends': instance.friends,
      'n': instance.n,
    };

AuthorRef _$AuthorRefFromJson(Map<String, dynamic> json) {
  return AuthorRef(
    id: json['id'] as String?,
    name: json['name'] as String?,
    posts: json['posts'] as List<dynamic>?,
    friends: json['friends'] as List<dynamic>?,
    n: json['n'] as int?,
  );
}

Map<String, dynamic> _$AuthorRefToJson(AuthorRef instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'posts': instance.posts,
      'friends': instance.friends,
      'n': instance.n,
    };

PostOrder _$PostOrderFromJson(Map<String, dynamic> json) {
  return PostOrder(
    asc: json['asc'],
    desc: json['desc'],
    then: json['then'],
  );
}

Map<String, dynamic> _$PostOrderToJson(PostOrder instance) => <String, dynamic>{
      'asc': instance.asc,
      'desc': instance.desc,
      'then': instance.then,
    };

IntRange _$IntRangeFromJson(Map<String, dynamic> json) {
  return IntRange(
    min: json['min'] as int,
    max: json['max'] as int,
  );
}

Map<String, dynamic> _$IntRangeToJson(IntRange instance) => <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
    };

NearFilter _$NearFilterFromJson(Map<String, dynamic> json) {
  return NearFilter(
    distance: (json['distance'] as num).toDouble(),
    coordinate: json['coordinate'],
  );
}

Map<String, dynamic> _$NearFilterToJson(NearFilter instance) =>
    <String, dynamic>{
      'distance': instance.distance,
      'coordinate': instance.coordinate,
    };

ContainsFilter _$ContainsFilterFromJson(Map<String, dynamic> json) {
  return ContainsFilter(
    point: json['point'],
    polygon: json['polygon'],
  );
}

Map<String, dynamic> _$ContainsFilterToJson(ContainsFilter instance) =>
    <String, dynamic>{
      'point': instance.point,
      'polygon': instance.polygon,
    };

UpdatePostInput _$UpdatePostInputFromJson(Map<String, dynamic> json) {
  return UpdatePostInput(
    filter: json['filter'],
    set: json['set'],
    remove: json['remove'],
  );
}

Map<String, dynamic> _$UpdatePostInputToJson(UpdatePostInput instance) =>
    <String, dynamic>{
      'filter': instance.filter,
      'set': instance.set,
      'remove': instance.remove,
    };

PointGeoFilter _$PointGeoFilterFromJson(Map<String, dynamic> json) {
  return PointGeoFilter(
    near: json['near'],
    within: json['within'],
  );
}

Map<String, dynamic> _$PointGeoFilterToJson(PointGeoFilter instance) =>
    <String, dynamic>{
      'near': instance.near,
      'within': instance.within,
    };

UserPatch _$UserPatchFromJson(Map<String, dynamic> json) {
  return UserPatch(
    name: json['name'] as String?,
    tasks: json['tasks'] as List<dynamic>?,
  );
}

Map<String, dynamic> _$UserPatchToJson(UserPatch instance) => <String, dynamic>{
      'name': instance.name,
      'tasks': instance.tasks,
    };

Int64Range _$Int64RangeFromJson(Map<String, dynamic> json) {
  return Int64Range(
    min: json['min'] as int,
    max: json['max'] as int,
  );
}

Map<String, dynamic> _$Int64RangeToJson(Int64Range instance) =>
    <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
    };

PolygonRef _$PolygonRefFromJson(Map<String, dynamic> json) {
  return PolygonRef(
    coordinates: json['coordinates'] as List<dynamic>,
  );
}

Map<String, dynamic> _$PolygonRefToJson(PolygonRef instance) =>
    <String, dynamic>{
      'coordinates': instance.coordinates,
    };

MultiPolygonRef _$MultiPolygonRefFromJson(Map<String, dynamic> json) {
  return MultiPolygonRef(
    polygons: json['polygons'] as List<dynamic>,
  );
}

Map<String, dynamic> _$MultiPolygonRefToJson(MultiPolygonRef instance) =>
    <String, dynamic>{
      'polygons': instance.polygons,
    };

WithinFilter _$WithinFilterFromJson(Map<String, dynamic> json) {
  return WithinFilter(
    polygon: json['polygon'],
  );
}

Map<String, dynamic> _$WithinFilterToJson(WithinFilter instance) =>
    <String, dynamic>{
      'polygon': instance.polygon,
    };

StringHashFilter _$StringHashFilterFromJson(Map<String, dynamic> json) {
  return StringHashFilter(
    eq: json['eq'] as String?,
    d_in: (json['d_in'] as List<dynamic>?)?.map((e) => e as String?).toList(),
  );
}

Map<String, dynamic> _$StringHashFilterToJson(StringHashFilter instance) =>
    <String, dynamic>{
      'eq': instance.eq,
      'd_in': instance.d_in,
    };

StringRange _$StringRangeFromJson(Map<String, dynamic> json) {
  return StringRange(
    min: json['min'] as String,
    max: json['max'] as String,
  );
}

Map<String, dynamic> _$StringRangeToJson(StringRange instance) =>
    <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
    };

StringFullTextFilter _$StringFullTextFilterFromJson(Map<String, dynamic> json) {
  return StringFullTextFilter(
    alloftext: json['alloftext'] as String?,
    anyoftext: json['anyoftext'] as String?,
  );
}

Map<String, dynamic> _$StringFullTextFilterToJson(
        StringFullTextFilter instance) =>
    <String, dynamic>{
      'alloftext': instance.alloftext,
      'anyoftext': instance.anyoftext,
    };

UpdateTaskInput _$UpdateTaskInputFromJson(Map<String, dynamic> json) {
  return UpdateTaskInput(
    filter: json['filter'],
    set: json['set'],
    remove: json['remove'],
  );
}

Map<String, dynamic> _$UpdateTaskInputToJson(UpdateTaskInput instance) =>
    <String, dynamic>{
      'filter': instance.filter,
      'set': instance.set,
      'remove': instance.remove,
    };

StringRegExpFilter _$StringRegExpFilterFromJson(Map<String, dynamic> json) {
  return StringRegExpFilter(
    regexp: json['regexp'] as String?,
  );
}

Map<String, dynamic> _$StringRegExpFilterToJson(StringRegExpFilter instance) =>
    <String, dynamic>{
      'regexp': instance.regexp,
    };

TaskPatch _$TaskPatchFromJson(Map<String, dynamic> json) {
  return TaskPatch(
    title: json['title'] as String?,
    completed: json['completed'] as bool?,
    user: json['user'],
  );
}

Map<String, dynamic> _$TaskPatchToJson(TaskPatch instance) => <String, dynamic>{
      'title': instance.title,
      'completed': instance.completed,
      'user': instance.user,
    };

UserRef _$UserRefFromJson(Map<String, dynamic> json) {
  return UserRef(
    username: json['username'] as String?,
    name: json['name'] as String?,
    tasks: json['tasks'] as List<dynamic>?,
  );
}

Map<String, dynamic> _$UserRefToJson(UserRef instance) => <String, dynamic>{
      'username': instance.username,
      'name': instance.name,
      'tasks': instance.tasks,
    };

FloatRange _$FloatRangeFromJson(Map<String, dynamic> json) {
  return FloatRange(
    min: (json['min'] as num).toDouble(),
    max: (json['max'] as num).toDouble(),
  );
}

Map<String, dynamic> _$FloatRangeToJson(FloatRange instance) =>
    <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
    };

FloatFilter _$FloatFilterFromJson(Map<String, dynamic> json) {
  return FloatFilter(
    eq: (json['eq'] as num?)?.toDouble(),
    le: (json['le'] as num?)?.toDouble(),
    lt: (json['lt'] as num?)?.toDouble(),
    ge: (json['ge'] as num?)?.toDouble(),
    gt: (json['gt'] as num?)?.toDouble(),
    between: json['between'],
  );
}

Map<String, dynamic> _$FloatFilterToJson(FloatFilter instance) =>
    <String, dynamic>{
      'eq': instance.eq,
      'le': instance.le,
      'lt': instance.lt,
      'ge': instance.ge,
      'gt': instance.gt,
      'between': instance.between,
    };

HelloI _$HelloIFromJson(Map<String, dynamic> json) {
  return HelloI(
    n: json['n'] as int?,
  );
}

Map<String, dynamic> _$HelloIToJson(HelloI instance) => <String, dynamic>{
      'n': instance.n,
    };

TaskFilter _$TaskFilterFromJson(Map<String, dynamic> json) {
  return TaskFilter(
    id: (json['id'] as List<dynamic>?)?.map((e) => e as String).toList(),
    completed: json['completed'] as bool?,
    has: json['has'],
    and: json['and'] as List<dynamic>?,
    or: json['or'] as List<dynamic>?,
    not: json['not'],
  );
}

Map<String, dynamic> _$TaskFilterToJson(TaskFilter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'completed': instance.completed,
      'has': instance.has,
      'and': instance.and,
      'or': instance.or,
      'not': instance.not,
    };

AuthorOrder _$AuthorOrderFromJson(Map<String, dynamic> json) {
  return AuthorOrder(
    asc: json['asc'],
    desc: json['desc'],
    then: json['then'],
  );
}

Map<String, dynamic> _$AuthorOrderToJson(AuthorOrder instance) =>
    <String, dynamic>{
      'asc': instance.asc,
      'desc': instance.desc,
      'then': instance.then,
    };

PointRef _$PointRefFromJson(Map<String, dynamic> json) {
  return PointRef(
    longitude: (json['longitude'] as num).toDouble(),
    latitude: (json['latitude'] as num).toDouble(),
  );
}

Map<String, dynamic> _$PointRefToJson(PointRef instance) => <String, dynamic>{
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };

AddAuthorInput _$AddAuthorInputFromJson(Map<String, dynamic> json) {
  return AddAuthorInput(
    name: json['name'] as String,
    posts: json['posts'] as List<dynamic>?,
    friends: json['friends'] as List<dynamic>?,
    n: json['n'] as int?,
  );
}

Map<String, dynamic> _$AddAuthorInputToJson(AddAuthorInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'posts': instance.posts,
      'friends': instance.friends,
      'n': instance.n,
    };

PostFilter _$PostFilterFromJson(Map<String, dynamic> json) {
  return PostFilter(
    id: (json['id'] as List<dynamic>?)?.map((e) => e as String).toList(),
    title: json['title'],
    score: json['score'],
    completed: json['completed'] as bool?,
    datePublished: json['datePublished'],
    has: json['has'],
    and: json['and'] as List<dynamic>?,
    or: json['or'] as List<dynamic>?,
    not: json['not'],
  );
}

Map<String, dynamic> _$PostFilterToJson(PostFilter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'score': instance.score,
      'completed': instance.completed,
      'datePublished': instance.datePublished,
      'has': instance.has,
      'and': instance.and,
      'or': instance.or,
      'not': instance.not,
    };

TaskRef _$TaskRefFromJson(Map<String, dynamic> json) {
  return TaskRef(
    id: json['id'] as String?,
    title: json['title'] as String?,
    completed: json['completed'] as bool?,
    user: json['user'],
  );
}

Map<String, dynamic> _$TaskRefToJson(TaskRef instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'completed': instance.completed,
      'user': instance.user,
    };

DateTimeRange _$DateTimeRangeFromJson(Map<String, dynamic> json) {
  return DateTimeRange(
    min: json['min'],
    max: json['max'],
  );
}

Map<String, dynamic> _$DateTimeRangeToJson(DateTimeRange instance) =>
    <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
    };

PointListRef _$PointListRefFromJson(Map<String, dynamic> json) {
  return PointListRef(
    points: json['points'] as List<dynamic>,
  );
}

Map<String, dynamic> _$PointListRefToJson(PointListRef instance) =>
    <String, dynamic>{
      'points': instance.points,
    };

Int64Filter _$Int64FilterFromJson(Map<String, dynamic> json) {
  return Int64Filter(
    eq: json['eq'] as int?,
    le: json['le'] as int?,
    lt: json['lt'] as int?,
    ge: json['ge'] as int?,
    gt: json['gt'] as int?,
    between: json['between'],
  );
}

Map<String, dynamic> _$Int64FilterToJson(Int64Filter instance) =>
    <String, dynamic>{
      'eq': instance.eq,
      'le': instance.le,
      'lt': instance.lt,
      'ge': instance.ge,
      'gt': instance.gt,
      'between': instance.between,
    };

UpdateUserInput _$UpdateUserInputFromJson(Map<String, dynamic> json) {
  return UpdateUserInput(
    filter: json['filter'],
    set: json['set'],
    remove: json['remove'],
  );
}

Map<String, dynamic> _$UpdateUserInputToJson(UpdateUserInput instance) =>
    <String, dynamic>{
      'filter': instance.filter,
      'set': instance.set,
      'remove': instance.remove,
    };

DateTimeFilter _$DateTimeFilterFromJson(Map<String, dynamic> json) {
  return DateTimeFilter(
    eq: json['eq'],
    le: json['le'],
    lt: json['lt'],
    ge: json['ge'],
    gt: json['gt'],
    between: json['between'],
  );
}

Map<String, dynamic> _$DateTimeFilterToJson(DateTimeFilter instance) =>
    <String, dynamic>{
      'eq': instance.eq,
      'le': instance.le,
      'lt': instance.lt,
      'ge': instance.ge,
      'gt': instance.gt,
      'between': instance.between,
    };

AuthorFilter _$AuthorFilterFromJson(Map<String, dynamic> json) {
  return AuthorFilter(
    id: (json['id'] as List<dynamic>?)?.map((e) => e as String).toList(),
    name: json['name'],
    has: json['has'],
    and: json['and'] as List<dynamic>?,
    or: json['or'] as List<dynamic>?,
    not: json['not'],
  );
}

Map<String, dynamic> _$AuthorFilterToJson(AuthorFilter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'has': instance.has,
      'and': instance.and,
      'or': instance.or,
      'not': instance.not,
    };

StringExactFilter _$StringExactFilterFromJson(Map<String, dynamic> json) {
  return StringExactFilter(
    eq: json['eq'] as String?,
    d_in: (json['d_in'] as List<dynamic>?)?.map((e) => e as String?).toList(),
    le: json['le'] as String?,
    lt: json['lt'] as String?,
    ge: json['ge'] as String?,
    gt: json['gt'] as String?,
    between: json['between'],
  );
}

Map<String, dynamic> _$StringExactFilterToJson(StringExactFilter instance) =>
    <String, dynamic>{
      'eq': instance.eq,
      'd_in': instance.d_in,
      'le': instance.le,
      'lt': instance.lt,
      'ge': instance.ge,
      'gt': instance.gt,
      'between': instance.between,
    };

PostRef _$PostRefFromJson(Map<String, dynamic> json) {
  return PostRef(
    id: json['id'] as String?,
    title: json['title'] as String?,
    text: json['text'] as String?,
    score: (json['score'] as num?)?.toDouble(),
    completed: json['completed'] as bool?,
    datePublished: json['datePublished'],
    author: json['author'],
  );
}

Map<String, dynamic> _$PostRefToJson(PostRef instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'text': instance.text,
      'score': instance.score,
      'completed': instance.completed,
      'datePublished': instance.datePublished,
      'author': instance.author,
    };

UserOrder _$UserOrderFromJson(Map<String, dynamic> json) {
  return UserOrder(
    asc: json['asc'],
    desc: json['desc'],
    then: json['then'],
  );
}

Map<String, dynamic> _$UserOrderToJson(UserOrder instance) => <String, dynamic>{
      'asc': instance.asc,
      'desc': instance.desc,
      'then': instance.then,
    };
