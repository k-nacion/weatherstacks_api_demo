import 'package:weatherstacks_api_demo/features/weather/domain/entities/weather.dart';

abstract class WeatherRemoteDataSource {
  Future<Weather> getCurrentWeather(String location);
}
