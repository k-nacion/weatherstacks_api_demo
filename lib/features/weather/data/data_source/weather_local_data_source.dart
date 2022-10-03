import 'package:weatherstacks_api_demo/features/weather/domain/entities/weather.dart';

abstract class WeatherLocalDataSource {
  Future<void> cacheWeather(Weather weather);
  Future<Weather> getLastCachedWeatherData();
}
