// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genre_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GenreResponseImpl _$$GenreResponseImplFromJson(Map<String, dynamic> json) =>
    _$GenreResponseImpl(
      genreCollection: (json['GenreCollection'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$GenreResponseImplToJson(_$GenreResponseImpl instance) =>
    <String, dynamic>{
      'GenreCollection': instance.genreCollection,
    };
