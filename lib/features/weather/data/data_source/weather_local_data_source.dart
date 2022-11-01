import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherstacks_api_demo/env/env.dart';
import 'package:weatherstacks_api_demo/error/exceptions.dart';
import 'package:weatherstacks_api_demo/features/weather/data/model/weather_model.dart';
import 'package:weatherstacks_api_demo/features/weather/data/model/weather_model2.dart';

const weatherDataKey = 'WEATHER_DATA_KEY';

abstract class WeatherLocalDataSource {
  @Deprecated('We are transitioning to OpenWeatherApi. '
      'WeatherStack API will not be used in the future.')
  Future<void> cacheWeather(WeatherModel weatherModel);

  @Deprecated('We are transitioning to OpenWeatherApi. '
      'WeatherStack API will not be used in the future.')
  Future<WeatherModel> getLastCachedWeatherData();

  Future<void> cacheWeather2(WeatherModel2 weatherModel2);
  Future<WeatherModel2> getLastCachedWeatherData2();
}

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final SharedPreferences _sharedPreferences;

  const WeatherLocalDataSourceImpl({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  @Deprecated('We are transitioning to OpenWeatherApi. '
      'WeatherStack API will not be used in the future.')
  @override
  Future<void> cacheWeather(WeatherModel weatherModel) async {
    if (!await _sharedPreferences.setString(
        Env.WEATHER_SHARED_PREF_KEY, jsonEncode(weatherModel.toMap()))) {
      throw CacheException();
    }
  }

  @Deprecated('We are transitioning to OpenWeatherApi. '
      'WeatherStack API will not be used in the future.')
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

  @override
  Future<void> cacheWeather2(WeatherModel2 weatherModel2) {
    // TODO: implement cacheWeather2
    throw UnimplementedError();
  }

  @override
  Future<WeatherModel2> getLastCachedWeatherData2() {
    // TODO: implement getLastCachedWeatherData2
    throw UnimplementedError();
  }
}
