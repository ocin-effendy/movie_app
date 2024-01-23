import 'dart:io';

import 'package:core/common/network_info.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/data/datasource/movie_remote_data_source.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  // final MovieLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  MovieRepositoryImpl({
    required this.remoteDataSource,
    // required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getNowPlayingMovies();
        // localDataSource.cacheNowPlayingMovies(
        //     result.map((movie) => MovieTable.fromDTO(movie)).toList());
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      } on TlsException catch (e) {
        return Left(TlsFailure('Invalid Certificate ${e.message}'));
      }
    } else {
      try {
        // final result = await localDataSource.getCachedNowPlayingMovies();
        final result = await remoteDataSource.getNowPlayingMovies();

        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }
}
