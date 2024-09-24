// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class BrowseSeriesRepositoriesParam extends Equatable {
  const BrowseSeriesRepositoriesParam({
    this.page,
    this.perPage = 10,
    this.type,
    this.format,
    this.season,
    this.genres,
    this.genresExclude,
    this.search,
  });
  final int? page;
  final int? perPage;
  final String? type;
  final String? format;
  final String? season;
  final List<String>? genres;
  final List<String>? genresExclude;
  final bool isAdult = false;
  final String? search;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if (page != null) map['page'] = page;
    if (perPage != null) map['perPage'] = perPage;
    if (type != null) map['type'] = type;
    if (format != null) map['format'] = format;
    if (season != null) map['season'] = season;
    if (genres != null) map['genres'] = genres;
    if (genresExclude != null) map['genresExclude'] = genresExclude;
    map['isAdult'] = isAdult;
    if (search != null) map['search'] = search;
    return map;
  }

  BrowseSeriesRepositoriesParam copyWith({
    int? page,
    int? perPage,
    String? type,
    String? format,
    String? season,
    List<String>? genres,
    List<String>? genresExclude,
    bool? isAdult,
    String? search,
  }) {
    return BrowseSeriesRepositoriesParam(
      page: this.page ?? page,
      perPage: this.perPage ?? perPage,
      type: this.type ?? type,
      format: this.format ?? format,
      season: this.season ?? season,
      genres: this.genres ?? genres,
      genresExclude: this.genresExclude ?? genresExclude,
      search: this.search ?? search,
    );
  }

  @override
  List<Object?> get props => [
        page,
        perPage,
        type,
        format,
        season,
        genres,
        genresExclude,
        search,
      ];
}
