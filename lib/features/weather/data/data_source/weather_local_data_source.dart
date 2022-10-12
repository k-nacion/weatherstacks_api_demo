import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherstacks_api_demo/features/weather/data/model/weather_model.dart';

const weatherDataKey = 'WEATHER_DATA_KEY';

abstract class WeatherLocalDataSource {
  Future<void> cacheWeather(WeatherModel weather);
  Future<WeatherModel> getLastCachedWeatherData();
}

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final SharedPreferences _sharedPreferences;

  const WeatherLocalDataSourceImpl({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  @override
  Future<void> cacheWeather(WeatherModel weather) async {
    // TODO: implement cacheWeather
    throw UnimplementedError();
  }

  @override
  Future<WeatherModel> getLastCachedWeatherData() async {
    // TODO: implement getLastCachedWeatherData
    throw UnimplementedError();
  }
}
