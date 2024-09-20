import 'dart:convert';
import 'dart:developer';
import 'package:app/core/core.dart';
import 'package:app/featues/genres/genres.dart';
import 'package:injectable/injectable.dart';

abstract class GenreRepository {
  Future<GenreResponse> genres();
}

@Injectable(as: GenreRepository)
class GenreReposityImpl implements GenreRepository {
  final GraphqlService _service;
  GenreReposityImpl(this._service);
  @override
  Future<GenreResponse> genres() async {
    try {
      final response = await _service.gql('genre_collection', {});
      return GenreResponse.fromJson(jsonDecode(response.body)['data']);
    } catch (e) {
      log('error=>${e.toString()}');
      rethrow;
    }
  }
}
