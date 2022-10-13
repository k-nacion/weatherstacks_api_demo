import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherstacks_api_demo/env/env.dart';
import 'package:weatherstacks_api_demo/error/exceptions.dart';
import 'package:weatherstacks_api_demo/features/weather/data/model/weather_model.dart';

const weatherDataKey = 'WEATHER_DATA_KEY';

abstract class WeatherLocalDataSource {
  Future<void> cacheWeather(WeatherModel weatherModel);

  Future<WeatherModel> getLastCachedWeatherData();
}

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final SharedPreferences _sharedPreferences;

  const WeatherLocalDataSourceImpl({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  @override
  Future<void> cacheWeather(WeatherModel weatherModel) async {
    if (!await _sharedPreferences.setString(
        Env.WEATHER_SHARED_PREF_KEY, jsonEncode(weatherModel.toMap()))) {
      throw CacheException();
    }
  }

  @override
  Future<WeatherModel> getLastCachedWeatherData() async {
    final serializedWeatherData = _sharedPreferences.getString(Env.WEATHER_SHARED_PREF_KEY);

    if (serializedWeatherData == null || serializedWeatherData.isEmpty) {
      throw CacheException();
    }

    final deserializedWeatherData = jsonDecode(serializedWeatherData);
    final weatherModel = WeatherModel.fromMap(deserializedWeatherData);

    return weatherModel;
  }
}
