import 'package:freezed_annotation/freezed_annotation.dart';

part 'browse_series_response.freezed.dart';
part 'browse_series_response.g.dart';

@freezed
class BrowseSeriesResponse with _$BrowseSeriesResponse {
  const factory BrowseSeriesResponse({
    @JsonKey(name: "Page") required Page page,
  }) = _BrowseSeriesResponse;

  factory BrowseSeriesResponse.fromJson(Map<String, dynamic> json) =>
      _$BrowseSeriesResponseFromJson(json);
}

@freezed
class Page with _$Page {
  const factory Page({
    required PageInfo pageInfo,
    List<Media>? media,
  }) = _Page;

  factory Page.fromJson(Map<String, dynamic> json) => _$PageFromJson(json);
}

@freezed
class Media with _$Media {
  const factory Media({
    int? id,
    required Title title,
    List<String>? genres,
    int? averageScore,
    int? popularity,
    String? season,
    String? description,
    List<String>? synonyms,
    required CoverImage coverImage,
  }) = _Media;

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);
}

@freezed
class CoverImage with _$CoverImage {
  const factory CoverImage({
    String? medium,
  }) = _CoverImage;

  factory CoverImage.fromJson(Map<String, dynamic> json) =>
      _$CoverImageFromJson(json);
}

@freezed
class Title with _$Title {
  const factory Title({
    String? userPreferred,
  }) = _Title;

  factory Title.fromJson(Map<String, dynamic> json) => _$TitleFromJson(json);
}

@freezed
class PageInfo with _$PageInfo {
  const factory PageInfo({
    required int total,
    required int perPage,
    required int currentPage,
    required int lastPage,
    required bool hasNextPage,
  }) = _PageInfo;

  factory PageInfo.fromJson(Map<String, dynamic> json) =>
      _$PageInfoFromJson(json);
}
