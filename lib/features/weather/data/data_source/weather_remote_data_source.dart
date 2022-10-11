import 'package:weatherstacks_api_demo/features/weather/data/model/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String location);
}
