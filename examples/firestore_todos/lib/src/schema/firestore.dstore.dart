// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'firestore.dart';

// **************************************************************************
// FireStoreSchemaGenerator
// **************************************************************************

@JsonSerializable()
class Movie {
  final String poster;

  final int likes;

  final String title;

  final int year;

  final String runtime;

  final String rated;

  final List<String> genre;

  @JsonKey(ignore: true)
  _$MovieCopyWith<Movie> get copyWith =>
      __$MovieCopyWithImpl<Movie>(this, IdentityFn);

  const Movie(
      {required this.poster,
      required this.likes,
      required this.title,
      required this.year,
      required this.runtime,
      required this.rated,
      required this.genre});

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is Movie &&
        o.poster == poster &&
        o.likes == likes &&
        o.title == title &&
        o.year == year &&
        o.runtime == runtime &&
        o.rated == rated &&
        o.genre == genre;
  }

  @override
  int get hashCode =>
      poster.hashCode ^
      likes.hashCode ^
      title.hashCode ^
      year.hashCode ^
      runtime.hashCode ^
      rated.hashCode ^
      genre.hashCode;

  @override
  String toString() =>
      "Movie(poster: ${this.poster}, likes: ${this.likes}, title: ${this.title}, year: ${this.year}, runtime: ${this.runtime}, rated: ${this.rated}, genre: ${this.genre})";
}

abstract class $MovieCopyWith<O> {
  factory $MovieCopyWith(Movie value, O Function(Movie) then) =
      _$MovieCopyWithImpl<O>;
  O call(
      {String poster,
      int likes,
      String title,
      int year,
      String runtime,
      String rated,
      List<String> genre});
}

class _$MovieCopyWithImpl<O> implements $MovieCopyWith<O> {
  final Movie _value;
  final O Function(Movie) _then;
  _$MovieCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? poster = dimmutable,
      Object? likes = dimmutable,
      Object? title = dimmutable,
      Object? year = dimmutable,
      Object? runtime = dimmutable,
      Object? rated = dimmutable,
      Object? genre = dimmutable}) {
    return _then(_value.copyWith(
        poster: poster == dimmutable ? _value.poster : poster as String,
        likes: likes == dimmutable ? _value.likes : likes as int,
        title: title == dimmutable ? _value.title : title as String,
        year: year == dimmutable ? _value.year : year as int,
        runtime: runtime == dimmutable ? _value.runtime : runtime as String,
        rated: rated == dimmutable ? _value.rated : rated as String,
        genre: genre == dimmutable ? _value.genre : genre as List<String>));
  }
}

abstract class _$MovieCopyWith<O> implements $MovieCopyWith<O> {
  factory _$MovieCopyWith(Movie value, O Function(Movie) then) =
      __$MovieCopyWithImpl<O>;
  O call(
      {String poster,
      int likes,
      String title,
      int year,
      String runtime,
      String rated,
      List<String> genre});
}

class __$MovieCopyWithImpl<O> extends _$MovieCopyWithImpl<O>
    implements _$MovieCopyWith<O> {
  __$MovieCopyWithImpl(Movie _value, O Function(Movie) _then)
      : super(_value, (v) => _then(v));

  @override
  Movie get _value => super._value;

  @override
  O call(
      {Object? poster = dimmutable,
      Object? likes = dimmutable,
      Object? title = dimmutable,
      Object? year = dimmutable,
      Object? runtime = dimmutable,
      Object? rated = dimmutable,
      Object? genre = dimmutable}) {
    return _then(Movie(
        poster: poster == dimmutable ? _value.poster : poster as String,
        likes: likes == dimmutable ? _value.likes : likes as int,
        title: title == dimmutable ? _value.title : title as String,
        year: year == dimmutable ? _value.year : year as int,
        runtime: runtime == dimmutable ? _value.runtime : runtime as String,
        rated: rated == dimmutable ? _value.rated : rated as String,
        genre: genre == dimmutable ? _value.genre : genre as List<String>));
  }
}

class FireStoreQuery {
  movies_MovieQuery movies_Movie() {
    throw Error();
  }
}

class movies_MovieQuery {
  void limit(int limit) {}
  void limitToLast(int limit) {}
  void orderBy(Object field, {bool descending = false}) {}
  void where(
    Object field, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<Object?>? arrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? isNull,
  }) {}

  void where_poster(
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    String? whereIn,
    String? whereNotIn,
  ) {}
  void orderBy_poster({bool descending = false}) {}

  void where_likes(
    int? isEqualTo,
    int? isNotEqualTo,
    int? isLessThan,
    int? isLessThanOrEqualTo,
    int? isGreaterThan,
    int? isGreaterThanOrEqualTo,
    int? whereIn,
    int? whereNotIn,
  ) {}
  void orderBy_likes({bool descending = false}) {}

  void where_title(
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    String? whereIn,
    String? whereNotIn,
  ) {}
  void orderBy_title({bool descending = false}) {}

  void where_year(
    int? isEqualTo,
    int? isNotEqualTo,
    int? isLessThan,
    int? isLessThanOrEqualTo,
    int? isGreaterThan,
    int? isGreaterThanOrEqualTo,
    int? whereIn,
    int? whereNotIn,
  ) {}
  void orderBy_year({bool descending = false}) {}

  void where_runtime(
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    String? whereIn,
    String? whereNotIn,
  ) {}
  void orderBy_runtime({bool descending = false}) {}

  void where_rated(
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    String? whereIn,
    String? whereNotIn,
  ) {}
  void orderBy_rated({bool descending = false}) {}

  void where_genre({
    Object? arrayContains,
    List<Object?>? arrayContainsAny,
  }) {}
}
