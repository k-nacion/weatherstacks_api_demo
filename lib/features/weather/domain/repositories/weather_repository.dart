import 'package:fpdart/fpdart.dart';
import 'package:weatherstacks_api_demo/error/failures.dart';
import 'package:weatherstacks_api_demo/features/weather/domain/entities/coordinates.dart';
import 'package:weatherstacks_api_demo/features/weather/domain/entities/weather.dart';
import 'package:weatherstacks_api_demo/features/weather/domain/entities/weather2.dart';

abstract class WeatherRepository {
  @Deprecated(
      'We are transitioning to OpenWeatherApi. WeatherStack API will not be used in the future.')
  Future<Either<Failure, Weather>> getCurrentWeather(String location);
  Future<Either<Failure, Weather2>> getCurrentWeatherFromOpenWeatherApi(Coordinates coordinates);
}
