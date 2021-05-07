// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return Movie(
    poster: json['poster'] as String,
    likes: json['likes'] as int,
    title: json['title'] as String,
    year: json['year'] as int,
    runtime: json['runtime'] as String,
    rated: json['rated'] as String,
    genre: (json['genre'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'poster': instance.poster,
      'likes': instance.likes,
      'title': instance.title,
      'year': instance.year,
      'runtime': instance.runtime,
      'rated': instance.rated,
      'genre': instance.genre,
    };
