import 'package:fpdart/src/either.dart';
import 'package:weatherstacks_api_demo/error/exceptions.dart';
import 'package:weatherstacks_api_demo/error/failures.dart';
import 'package:weatherstacks_api_demo/features/weather/data/data_source/weather_local_data_source.dart';
import 'package:weatherstacks_api_demo/features/weather/data/data_source/weather_remote_data_source.dart';
import 'package:weatherstacks_api_demo/features/weather/domain/entities/weather.dart';
import 'package:weatherstacks_api_demo/features/weather/domain/repositories/weather_repository.dart';

import '../data_source/network_info.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherLocalDataSource _localDataSource;
  final WeatherRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  const WeatherRepositoryImpl({
    required WeatherLocalDataSource localDataSource,
    required WeatherRemoteDataSource remoteDataSource,
    required NetworkInfo networkInfo,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource,
        _networkInfo = networkInfo;

  @override
  Future<Either<Failure, Weather>> getCurrentWeather(String location) async {
    try {
      if (!await _networkInfo.hasInternet) {
        return Right(await _localDataSource.getLastCachedWeatherData());
      }

      final currentWeather = await _remoteDataSource.getCurrentWeather(location);
      _localDataSource.cacheWeather(currentWeather);
      return Right(currentWeather);
    } on ServerUnreachableException {
      return const Left(ServerUnreachableFailure());
    } on CacheException {
      return const Left(CacheFailure());
    }
  }
}
