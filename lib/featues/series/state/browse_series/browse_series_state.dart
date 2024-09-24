part of 'browse_series_cubit.dart';

@freezed
class BrowseSeriesState with _$BrowseSeriesState {
  const factory BrowseSeriesState.initial() = _Initial;
  const factory BrowseSeriesState.loading() = _Loading;
  const factory BrowseSeriesState.failure(String message) = _Failure;
  const factory BrowseSeriesState.success(BrowseSeriesResponse response) =
      _Success;
}
