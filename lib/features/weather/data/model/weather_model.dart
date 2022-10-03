import 'package:weatherstacks_api_demo/features/weather/domain/entities/weather.dart';

class WeatherModel extends Weather {
  WeatherModel({required super.temperature, required super.weatherCode, required super.weatherIcons, required super.weatherDescriptions});
}
