// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../api/api_service.dart' as _i299;
import '../core/network/internet_checker.dart' as _i117;
import '../features/home/bloc/home_cubit.dart' as _i641;
import '../features/home/data/local/home_local_repo.dart' as _i1042;
import '../features/home/data/local/home_repo_local_impl.dart' as _i710;
import '../features/home/data/remote/home__remote_repo.dart' as _i850;
import '../features/home/data/remote/home_repo_remote_impl.dart' as _i616;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i117.InternetConnectivity>(
      () => _i117.InternetConnectivity(),
    );
    gh.lazySingleton<_i299.ApiService>(() => _i299.ApiService());
    gh.factory<_i1042.HomeLocalRepo>(() => _i710.HomeRepoLocal());
    gh.factory<_i850.HomeRemoteRepo>(() => _i616.HomeRepoRemoteImpl());
    gh.factory<_i641.HomeCubit>(
      () => _i641.HomeCubit(
        gh<_i850.HomeRemoteRepo>(),
        gh<_i1042.HomeLocalRepo>(),
        gh<_i117.InternetConnectivity>(),
      ),
    );
    return this;
  }
}
