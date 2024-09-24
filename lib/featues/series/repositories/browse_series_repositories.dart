// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:injectable/injectable.dart';

import 'package:app/core/core.dart';
import 'package:app/featues/series/series.dart';

abstract class BrowseSeriesRepository {
  Future<BrowseSeriesResponse> fetch(BrowseSeriesRepositoriesParam param);
}

@Injectable(as: BrowseSeriesRepository)
class BrowseSeriesRepositoryImpl implements BrowseSeriesRepository {
  final GraphqlService _service;
  BrowseSeriesRepositoryImpl(this._service);
  @override
  Future<BrowseSeriesResponse> fetch(
      BrowseSeriesRepositoriesParam param) async {
    try {
      final response = await _service.gql("browse_series", param.toMap());
      return BrowseSeriesResponse.fromJson(jsonDecode(response.body)['data']);
    } catch (e) {
      log('error=>${e.toString()}');
      rethrow;
    }
  }
}
