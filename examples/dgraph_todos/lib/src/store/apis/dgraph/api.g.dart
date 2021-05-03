// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FloatFilter _$FloatFilterFromJson(Map<String, dynamic> json) {
  return FloatFilter(
    eq: (json['eq'] as num?)?.toDouble(),
    le: (json['le'] as num?)?.toDouble(),
    lt: (json['lt'] as num?)?.toDouble(),
    ge: (json['ge'] as num?)?.toDouble(),
    gt: (json['gt'] as num?)?.toDouble(),
    between: json['between'] == null
        ? null
        : FloatRange.fromJson(json['between'] as Map<String, dynamic>),
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
    has: _$enumDecodeNullable(_$TaskHasFilterEnumMap, json['has']),
    and: (json['and'] as List<dynamic>?)
        ?.map((e) =>
            e == null ? null : TaskFilter.fromJson(e as Map<String, dynamic>))
        .toList(),
    or: (json['or'] as List<dynamic>?)
        ?.map((e) =>
            e == null ? null : TaskFilter.fromJson(e as Map<String, dynamic>))
        .toList(),
    not: json['not'] == null
        ? null
        : TaskFilter.fromJson(json['not'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TaskFilterToJson(TaskFilter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'completed': instance.completed,
      'has': _$TaskHasFilterEnumMap[instance.has],
      'and': instance.and,
      'or': instance.or,
      'not': instance.not,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$TaskHasFilterEnumMap = {
  TaskHasFilter.title: 'title',
  TaskHasFilter.completed: 'completed',
  TaskHasFilter.user: 'user',
};

AuthorOrder _$AuthorOrderFromJson(Map<String, dynamic> json) {
  return AuthorOrder(
    asc: _$enumDecodeNullable(_$AuthorOrderableEnumMap, json['asc']),
    desc: _$enumDecodeNullable(_$AuthorOrderableEnumMap, json['desc']),
    then: json['then'] == null
        ? null
        : AuthorOrder.fromJson(json['then'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AuthorOrderToJson(AuthorOrder instance) =>
    <String, dynamic>{
      'asc': _$AuthorOrderableEnumMap[instance.asc],
      'desc': _$AuthorOrderableEnumMap[instance.desc],
      'then': instance.then,
    };

const _$AuthorOrderableEnumMap = {
  AuthorOrderable.name: 'name',
  AuthorOrderable.n: 'n',
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
    posts: (json['posts'] as List<dynamic>?)
        ?.map((e) => PostRef.fromJson(e as Map<String, dynamic>))
        .toList(),
    friends: (json['friends'] as List<dynamic>?)
        ?.map((e) =>
            e == null ? null : AuthorRef.fromJson(e as Map<String, dynamic>))
        .toList(),
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
    title: json['title'] == null
        ? null
        : StringTermFilter.fromJson(json['title'] as Map<String, dynamic>),
    score: json['score'] == null
        ? null
        : FloatFilter.fromJson(json['score'] as Map<String, dynamic>),
    completed: json['completed'] as bool?,
    datePublished: json['datePublished'] == null
        ? null
        : DateTimeFilter.fromJson(
            json['datePublished'] as Map<String, dynamic>),
    has: _$enumDecodeNullable(_$PostHasFilterEnumMap, json['has']),
    and: (json['and'] as List<dynamic>?)
        ?.map((e) =>
            e == null ? null : PostFilter.fromJson(e as Map<String, dynamic>))
        .toList(),
    or: (json['or'] as List<dynamic>?)
        ?.map((e) =>
            e == null ? null : PostFilter.fromJson(e as Map<String, dynamic>))
        .toList(),
    not: json['not'] == null
        ? null
        : PostFilter.fromJson(json['not'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PostFilterToJson(PostFilter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'score': instance.score,
      'completed': instance.completed,
      'datePublished': instance.datePublished,
      'has': _$PostHasFilterEnumMap[instance.has],
      'and': instance.and,
      'or': instance.or,
      'not': instance.not,
    };

const _$PostHasFilterEnumMap = {
  PostHasFilter.title: 'title',
  PostHasFilter.text: 'text',
  PostHasFilter.score: 'score',
  PostHasFilter.completed: 'completed',
  PostHasFilter.datePublished: 'datePublished',
  PostHasFilter.author: 'author',
};

TaskRef _$TaskRefFromJson(Map<String, dynamic> json) {
  return TaskRef(
    id: json['id'] as String?,
    title: json['title'] as String?,
    completed: json['completed'] as bool?,
    user: json['user'] == null
        ? null
        : UserRef.fromJson(json['user'] as Map<String, dynamic>),
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
    points: (json['points'] as List<dynamic>)
        .map((e) => PointRef.fromJson(e as Map<String, dynamic>))
        .toList(),
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
    between: json['between'] == null
        ? null
        : Int64Range.fromJson(json['between'] as Map<String, dynamic>),
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
    filter: UserFilter.fromJson(json['filter'] as Map<String, dynamic>),
    set: json['set'] == null
        ? null
        : UserPatch.fromJson(json['set'] as Map<String, dynamic>),
    remove: json['remove'] == null
        ? null
        : UserPatch.fromJson(json['remove'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateUserInputToJson(UpdateUserInput instance) =>
    <String, dynamic>{
      'filter': instance.filter,
      'set': instance.set,
      'remove': instance.remove,
    };

AuthorFilter _$AuthorFilterFromJson(Map<String, dynamic> json) {
  return AuthorFilter(
    id: (json['id'] as List<dynamic>?)?.map((e) => e as String).toList(),
    name: json['name'] == null
        ? null
        : StringTermFilter.fromJson(json['name'] as Map<String, dynamic>),
    has: _$enumDecodeNullable(_$AuthorHasFilterEnumMap, json['has']),
    and: (json['and'] as List<dynamic>?)
        ?.map((e) =>
            e == null ? null : AuthorFilter.fromJson(e as Map<String, dynamic>))
        .toList(),
    or: (json['or'] as List<dynamic>?)
        ?.map((e) =>
            e == null ? null : AuthorFilter.fromJson(e as Map<String, dynamic>))
        .toList(),
    not: json['not'] == null
        ? null
        : AuthorFilter.fromJson(json['not'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AuthorFilterToJson(AuthorFilter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'has': _$AuthorHasFilterEnumMap[instance.has],
      'and': instance.and,
      'or': instance.or,
      'not': instance.not,
    };

const _$AuthorHasFilterEnumMap = {
  AuthorHasFilter.name: 'name',
  AuthorHasFilter.posts: 'posts',
  AuthorHasFilter.friends: 'friends',
  AuthorHasFilter.n: 'n',
};

DateTimeFilter _$DateTimeFilterFromJson(Map<String, dynamic> json) {
  return DateTimeFilter(
    eq: json['eq'],
    le: json['le'],
    lt: json['lt'],
    ge: json['ge'],
    gt: json['gt'],
    between: json['between'] == null
        ? null
        : DateTimeRange.fromJson(json['between'] as Map<String, dynamic>),
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

StringExactFilter _$StringExactFilterFromJson(Map<String, dynamic> json) {
  return StringExactFilter(
    eq: json['eq'] as String?,
    in_$d: (json['in'] as List<dynamic>?)?.map((e) => e as String?).toList(),
    le: json['le'] as String?,
    lt: json['lt'] as String?,
    ge: json['ge'] as String?,
    gt: json['gt'] as String?,
    between: json['between'] == null
        ? null
        : StringRange.fromJson(json['between'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$StringExactFilterToJson(StringExactFilter instance) =>
    <String, dynamic>{
      'eq': instance.eq,
      'in': instance.in_$d,
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
    author: json['author'] == null
        ? null
        : AuthorRef.fromJson(json['author'] as Map<String, dynamic>),
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
    asc: _$enumDecodeNullable(_$UserOrderableEnumMap, json['asc']),
    desc: _$enumDecodeNullable(_$UserOrderableEnumMap, json['desc']),
    then: json['then'] == null
        ? null
        : UserOrder.fromJson(json['then'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserOrderToJson(UserOrder instance) => <String, dynamic>{
      'asc': _$UserOrderableEnumMap[instance.asc],
      'desc': _$UserOrderableEnumMap[instance.desc],
      'then': instance.then,
    };

const _$UserOrderableEnumMap = {
  UserOrderable.username: 'username',
  UserOrderable.name: 'name',
};

UpdateAuthorInput _$UpdateAuthorInputFromJson(Map<String, dynamic> json) {
  return UpdateAuthorInput(
    filter: AuthorFilter.fromJson(json['filter'] as Map<String, dynamic>),
    set: json['set'] == null
        ? null
        : AuthorPatch.fromJson(json['set'] as Map<String, dynamic>),
    remove: json['remove'] == null
        ? null
        : AuthorPatch.fromJson(json['remove'] as Map<String, dynamic>),
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
    user: UserRef.fromJson(json['user'] as Map<String, dynamic>),
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
    polygon: json['polygon'] == null
        ? null
        : PolygonRef.fromJson(json['polygon'] as Map<String, dynamic>),
    multiPolygon: json['multiPolygon'] == null
        ? null
        : MultiPolygonRef.fromJson(
            json['multiPolygon'] as Map<String, dynamic>),
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
    author: AuthorRef.fromJson(json['author'] as Map<String, dynamic>),
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
    tasks: (json['tasks'] as List<dynamic>?)
        ?.map((e) =>
            e == null ? null : TaskRef.fromJson(e as Map<String, dynamic>))
        .toList(),
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
    method: _$enumDecode(_$HTTPMethodEnumMap, json['method']),
    body: json['body'] as String?,
    graphql: json['graphql'] as String?,
    mode: _$enumDecodeNullable(_$ModeEnumMap, json['mode']),
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
      'method': _$HTTPMethodEnumMap[instance.method],
      'body': instance.body,
      'graphql': instance.graphql,
      'mode': _$ModeEnumMap[instance.mode],
      'forwardHeaders': instance.forwardHeaders,
      'secretHeaders': instance.secretHeaders,
      'introspectionHeaders': instance.introspectionHeaders,
      'skipIntrospection': instance.skipIntrospection,
    };

const _$HTTPMethodEnumMap = {
  HTTPMethod.GET: 'GET',
  HTTPMethod.POST: 'POST',
  HTTPMethod.PUT: 'PUT',
  HTTPMethod.PATCH: 'PATCH',
  HTTPMethod.DELETE: 'DELETE',
};

const _$ModeEnumMap = {
  Mode.BATCH: 'BATCH',
  Mode.SINGLE: 'SINGLE',
};

TaskOrder _$TaskOrderFromJson(Map<String, dynamic> json) {
  return TaskOrder(
    asc: _$enumDecodeNullable(_$TaskOrderableEnumMap, json['asc']),
    desc: _$enumDecodeNullable(_$TaskOrderableEnumMap, json['desc']),
    then: json['then'] == null
        ? null
        : TaskOrder.fromJson(json['then'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TaskOrderToJson(TaskOrder instance) => <String, dynamic>{
      'asc': _$TaskOrderableEnumMap[instance.asc],
      'desc': _$TaskOrderableEnumMap[instance.desc],
      'then': instance.then,
    };

const _$TaskOrderableEnumMap = {
  TaskOrderable.title: 'title',
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

PolygonGeoFilter _$PolygonGeoFilterFromJson(Map<String, dynamic> json) {
  return PolygonGeoFilter(
    near: json['near'] == null
        ? null
        : NearFilter.fromJson(json['near'] as Map<String, dynamic>),
    within: json['within'] == null
        ? null
        : WithinFilter.fromJson(json['within'] as Map<String, dynamic>),
    contains: json['contains'] == null
        ? null
        : ContainsFilter.fromJson(json['contains'] as Map<String, dynamic>),
    intersects: json['intersects'] == null
        ? null
        : IntersectsFilter.fromJson(json['intersects'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PolygonGeoFilterToJson(PolygonGeoFilter instance) =>
    <String, dynamic>{
      'near': instance.near,
      'within': instance.within,
      'contains': instance.contains,
      'intersects': instance.intersects,
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

PostPatch _$PostPatchFromJson(Map<String, dynamic> json) {
  return PostPatch(
    title: json['title'] as String?,
    text: json['text'] as String?,
    score: (json['score'] as num?)?.toDouble(),
    completed: json['completed'] as bool?,
    datePublished: json['datePublished'],
    author: json['author'] == null
        ? null
        : AuthorRef.fromJson(json['author'] as Map<String, dynamic>),
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

IntFilter _$IntFilterFromJson(Map<String, dynamic> json) {
  return IntFilter(
    eq: json['eq'] as int?,
    le: json['le'] as int?,
    lt: json['lt'] as int?,
    ge: json['ge'] as int?,
    gt: json['gt'] as int?,
    between: json['between'] == null
        ? null
        : IntRange.fromJson(json['between'] as Map<String, dynamic>),
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
    and: (json['and'] as List<dynamic>?)
        ?.map((e) =>
            e == null ? null : AuthRule.fromJson(e as Map<String, dynamic>))
        .toList(),
    or: (json['or'] as List<dynamic>?)
        ?.map((e) =>
            e == null ? null : AuthRule.fromJson(e as Map<String, dynamic>))
        .toList(),
    not: json['not'] == null
        ? null
        : AuthRule.fromJson(json['not'] as Map<String, dynamic>),
    rule: json['rule'] as String?,
  );
}

Map<String, dynamic> _$AuthRuleToJson(AuthRule instance) => <String, dynamic>{
      'and': instance.and,
      'or': instance.or,
      'not': instance.not,
      'rule': instance.rule,
    };

UserFilter _$UserFilterFromJson(Map<String, dynamic> json) {
  return UserFilter(
    username: json['username'] == null
        ? null
        : StringHashFilter.fromJson(json['username'] as Map<String, dynamic>),
    has: _$enumDecodeNullable(_$UserHasFilterEnumMap, json['has']),
    and: (json['and'] as List<dynamic>?)
        ?.map((e) =>
            e == null ? null : UserFilter.fromJson(e as Map<String, dynamic>))
        .toList(),
    or: (json['or'] as List<dynamic>?)
        ?.map((e) =>
            e == null ? null : UserFilter.fromJson(e as Map<String, dynamic>))
        .toList(),
    not: json['not'] == null
        ? null
        : UserFilter.fromJson(json['not'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserFilterToJson(UserFilter instance) =>
    <String, dynamic>{
      'username': instance.username,
      'has': _$UserHasFilterEnumMap[instance.has],
      'and': instance.and,
      'or': instance.or,
      'not': instance.not,
    };

const _$UserHasFilterEnumMap = {
  UserHasFilter.username: 'username',
  UserHasFilter.name: 'name',
  UserHasFilter.tasks: 'tasks',
};

AuthorPatch _$AuthorPatchFromJson(Map<String, dynamic> json) {
  return AuthorPatch(
    name: json['name'] as String?,
    posts: (json['posts'] as List<dynamic>?)
        ?.map((e) => PostRef.fromJson(e as Map<String, dynamic>))
        .toList(),
    friends: (json['friends'] as List<dynamic>?)
        ?.map((e) =>
            e == null ? null : AuthorRef.fromJson(e as Map<String, dynamic>))
        .toList(),
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
    posts: (json['posts'] as List<dynamic>?)
        ?.map((e) => PostRef.fromJson(e as Map<String, dynamic>))
        .toList(),
    friends: (json['friends'] as List<dynamic>?)
        ?.map((e) =>
            e == null ? null : AuthorRef.fromJson(e as Map<String, dynamic>))
        .toList(),
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
    asc: _$enumDecodeNullable(_$PostOrderableEnumMap, json['asc']),
    desc: _$enumDecodeNullable(_$PostOrderableEnumMap, json['desc']),
    then: json['then'] == null
        ? null
        : PostOrder.fromJson(json['then'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PostOrderToJson(PostOrder instance) => <String, dynamic>{
      'asc': _$PostOrderableEnumMap[instance.asc],
      'desc': _$PostOrderableEnumMap[instance.desc],
      'then': instance.then,
    };

const _$PostOrderableEnumMap = {
  PostOrderable.title: 'title',
  PostOrderable.text: 'text',
  PostOrderable.score: 'score',
  PostOrderable.datePublished: 'datePublished',
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
    coordinate: PointRef.fromJson(json['coordinate'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NearFilterToJson(NearFilter instance) =>
    <String, dynamic>{
      'distance': instance.distance,
      'coordinate': instance.coordinate,
    };

ContainsFilter _$ContainsFilterFromJson(Map<String, dynamic> json) {
  return ContainsFilter(
    point: json['point'] == null
        ? null
        : PointRef.fromJson(json['point'] as Map<String, dynamic>),
    polygon: json['polygon'] == null
        ? null
        : PolygonRef.fromJson(json['polygon'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ContainsFilterToJson(ContainsFilter instance) =>
    <String, dynamic>{
      'point': instance.point,
      'polygon': instance.polygon,
    };

UpdatePostInput _$UpdatePostInputFromJson(Map<String, dynamic> json) {
  return UpdatePostInput(
    filter: PostFilter.fromJson(json['filter'] as Map<String, dynamic>),
    set: json['set'] == null
        ? null
        : PostPatch.fromJson(json['set'] as Map<String, dynamic>),
    remove: json['remove'] == null
        ? null
        : PostPatch.fromJson(json['remove'] as Map<String, dynamic>),
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
    near: json['near'] == null
        ? null
        : NearFilter.fromJson(json['near'] as Map<String, dynamic>),
    within: json['within'] == null
        ? null
        : WithinFilter.fromJson(json['within'] as Map<String, dynamic>),
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
    tasks: (json['tasks'] as List<dynamic>?)
        ?.map((e) =>
            e == null ? null : TaskRef.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$UserPatchToJson(UserPatch instance) => <String, dynamic>{
      'name': instance.name,
      'tasks': instance.tasks,
    };

MultiPolygonRef _$MultiPolygonRefFromJson(Map<String, dynamic> json) {
  return MultiPolygonRef(
    polygons: (json['polygons'] as List<dynamic>)
        .map((e) => PolygonRef.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$MultiPolygonRefToJson(MultiPolygonRef instance) =>
    <String, dynamic>{
      'polygons': instance.polygons,
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
    coordinates: (json['coordinates'] as List<dynamic>)
        .map((e) => PointListRef.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$PolygonRefToJson(PolygonRef instance) =>
    <String, dynamic>{
      'coordinates': instance.coordinates,
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

WithinFilter _$WithinFilterFromJson(Map<String, dynamic> json) {
  return WithinFilter(
    polygon: PolygonRef.fromJson(json['polygon'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$WithinFilterToJson(WithinFilter instance) =>
    <String, dynamic>{
      'polygon': instance.polygon,
    };

StringHashFilter _$StringHashFilterFromJson(Map<String, dynamic> json) {
  return StringHashFilter(
    eq: json['eq'] as String?,
    in_$d: (json['in'] as List<dynamic>?)?.map((e) => e as String?).toList(),
  );
}

Map<String, dynamic> _$StringHashFilterToJson(StringHashFilter instance) =>
    <String, dynamic>{
      'eq': instance.eq,
      'in': instance.in_$d,
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
    filter: TaskFilter.fromJson(json['filter'] as Map<String, dynamic>),
    set: json['set'] == null
        ? null
        : TaskPatch.fromJson(json['set'] as Map<String, dynamic>),
    remove: json['remove'] == null
        ? null
        : TaskPatch.fromJson(json['remove'] as Map<String, dynamic>),
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
    user: json['user'] == null
        ? null
        : UserRef.fromJson(json['user'] as Map<String, dynamic>),
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
    tasks: (json['tasks'] as List<dynamic>?)
        ?.map((e) =>
            e == null ? null : TaskRef.fromJson(e as Map<String, dynamic>))
        .toList(),
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
