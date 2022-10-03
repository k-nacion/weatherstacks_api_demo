import 'package:fpdart/src/either.dart';
import 'package:weatherstacks_api_demo/error/failures.dart';
import 'package:weatherstacks_api_demo/features/weather/domain/entities/weather.dart';
import 'package:weatherstacks_api_demo/features/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository{
  @override
  Future<Either<Failure, Weather>> getCurrentWeather() {
    // TODO: implement getCurrentWeather
    throw UnimplementedError();
  }

}