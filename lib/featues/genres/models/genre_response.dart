import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'genre_response.freezed.dart';
part 'genre_response.g.dart';

@freezed
class GenreResponse with _$GenreResponse {
  const factory GenreResponse({
    @JsonKey(name: 'GenreCollection') required List<String> genreCollection,
  }) = _GenreResponse;
  factory GenreResponse.fromJson(Map<String, Object?> json) =>
      _$GenreResponseFromJson(json);
}
