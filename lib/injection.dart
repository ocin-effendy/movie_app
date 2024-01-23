import 'package:core/common/network_info.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movie/data/datasource/movie_remote_data_source.dart';
import 'package:movie/data/repositories/movie_repository_impl.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:movie/domain/usecase/get_now_playing_movies.dart';
import 'package:movie/presentation/bloc/now_playing_movies/now_playing_movies_bloc.dart';

final locator = GetIt.instance;

void init() {
  // Movie BLoc
  locator.registerFactory(
    () => NowPlayingMoviesBloc(
      locator(),
    ),
  );

  // movie Use Case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));

  // Movie Repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  // Movie Data Source
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));

  // network info
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  locator.registerLazySingleton(() => DataConnectionChecker());

  locator.registerLazySingleton(() => http.Client());
}
