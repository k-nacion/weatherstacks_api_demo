import 'dart:convert';

import 'package:http/http.dart';
import 'package:weatherstacks_api_demo/env/env.dart';
import 'package:weatherstacks_api_demo/env/private_env.dart';
import 'package:weatherstacks_api_demo/error/exceptions.dart';
import 'package:weatherstacks_api_demo/features/weather/data/model/weather_model.dart';
import 'package:weatherstacks_api_demo/features/weather/data/model/weather_model2.dart';
import 'package:weatherstacks_api_demo/features/weather/domain/entities/coordinates.dart';

const weatherUriHeader = {'content-type': 'application/json'};

abstract class WeatherRemoteDataSource {
  @Deprecated(
      'We are transitioning to OpenWeatherApi. WeatherStack API will not be used in the future.')
  Future<WeatherModel> getCurrentWeather(String location);
  Future<WeatherModel2> getWeatherFromOpenWeatherApi(Coordinates coordinates);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final Client _httpClient;

  const WeatherRemoteDataSourceImpl({
    required Client httpClient,
  }) : _httpClient = httpClient;

  @override
  Future<WeatherModel> getCurrentWeather(String location) async {
    const baseUrl = Env.WEATHER_STACK_BASE_URL;
    const unencodedPath = Env.WEATHER_STACK_BASE_URL_UNENCODED_PATH;
    final mapQuery = {
      Env.WEATHER_STACK_BASE_URL_ACCESS_KEY_QUERY: PrivateEnv.weatherStackApiKey,
      Env.WEATHER_STACK_BASE_URL_QUERY_QUERY: location
    };

    final String response;
    try {
      response = await _httpClient.read(Uri.http(baseUrl, unencodedPath, mapQuery),
          headers: weatherUriHeader);
    } on ClientException {
      throw ServerUnreachableException();
    }

    final weatherModel = WeatherModel.fromMap(jsonDecode(response)['current']);

    return weatherModel;
  }

  @override
  Future<WeatherModel2> getWeatherFromOpenWeatherApi(Coordinates coordinates) {
    // TODO: implement getWeatherFromOpenWeatherApi
    throw UnimplementedError();
  }
}
