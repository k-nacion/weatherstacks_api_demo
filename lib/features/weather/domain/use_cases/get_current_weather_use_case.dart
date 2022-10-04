import 'package:fpdart/fpdart.dart';
import 'package:weatherstacks_api_demo/error/failures.dart';
import 'package:weatherstacks_api_demo/features/weather/domain/entities/weather.dart';
import 'package:weatherstacks_api_demo/features/weather/domain/repositories/weather_repository.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepository _repository;

  const GetCurrentWeatherUseCase({
    required WeatherRepository repository,
  }) : _repository = repository;

  Future<Either<Failure, Weather>> call(String location) async => await _repository.getCurrentWeather(location);
}
