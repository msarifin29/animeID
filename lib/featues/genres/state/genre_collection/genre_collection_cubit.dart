import 'dart:async';

import 'package:app/featues/genres/genres.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'genre_collection_cubit.freezed.dart';

@injectable
class GenreCollectionCubit extends Cubit<GenreCollectionState> {
  final GenreRepository _repository;
  GenreCollectionCubit(this._repository)
      : super(const GenreCollectionState.initial());
  FutureOr<void> init() async {
    emit(const GenreCollectionState.loading());
    try {
      final response = await _repository.genres();

      emit(GenreCollectionState.success(response));
    } catch (e) {
      emit(GenreCollectionState.failure(e.toString()));
    }
  }
}

@freezed
class GenreCollectionState with _$GenreCollectionState {
  const factory GenreCollectionState.initial() = _Initial;
  const factory GenreCollectionState.loading() = _Loading;
  const factory GenreCollectionState.failure([@Default('') String message]) =
      _Failure;
  const factory GenreCollectionState.success(GenreResponse response) = _Success;
}
