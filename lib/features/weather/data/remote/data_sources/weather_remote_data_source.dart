import 'package:fpdart/fpdart.dart';
import 'package:weatherstacks_api_demo/error/failures.dart';
import 'package:weatherstacks_api_demo/features/weather/domain/entities/weather.dart';

abstract class WeatherRemoteDataSource{
  Either<Failure, Weather> getCurrentWeather(String location);
}