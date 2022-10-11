import 'package:weatherstacks_api_demo/features/weather/data/model/weather_model.dart';

abstract class WeatherLocalDataSource {
  Future<void> cacheWeather(WeatherModel weather);
  Future<WeatherModel> getLastCachedWeatherData();
}
