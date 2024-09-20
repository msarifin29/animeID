// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app/core/core.dart' as _i648;
import 'package:app/core/utils/graphql_service.dart' as _i976;
import 'package:app/featues/genres/genres.dart' as _i375;
import 'package:app/featues/genres/repositories/genre_repository.dart' as _i369;
import 'package:app/featues/genres/state/genre_collection/genre_collection_cubit.dart'
    as _i997;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i976.GraphqlService>(() => _i976.GraphqlService());
    gh.factory<_i369.GenreRepository>(
        () => _i369.GenreReposityImpl(gh<_i648.GraphqlService>()));
    gh.factory<_i997.GenreCollectionCubit>(
        () => _i997.GenreCollectionCubit(gh<_i375.GenreRepository>()));
    return this;
  }
}
