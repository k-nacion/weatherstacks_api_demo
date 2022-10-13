import 'package:http/http.dart';
import 'package:weatherstacks_api_demo/features/weather/data/model/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String location);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final Client _httpClient;

  const WeatherRemoteDataSourceImpl({
    required Client httpClient,
  }) : _httpClient = httpClient;

  @override
  Future<WeatherModel> getCurrentWeather(String location) {
    // TODO: implement getCurrentWeather
    throw UnimplementedError();
  }
}
