import 'package:app/featues/series/series.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'browse_series_state.dart';
part 'browse_series_cubit.freezed.dart';

@injectable
class BrowseSeriesCubit extends Cubit<BrowseSeriesState> {
  final BrowseSeriesRepository _repository;
  BrowseSeriesCubit(this._repository)
      : super(const BrowseSeriesState.initial());
  Future<void> init(BrowseSeriesRepositoriesParam param) async {
    emit(const BrowseSeriesState.loading());
    try {
      final response = await _repository.fetch(param);
      emit(BrowseSeriesState.success(response));
    } catch (e) {
      emit(BrowseSeriesState.failure(e.toString()));
    }
  }
}
