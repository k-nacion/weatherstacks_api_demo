import 'package:weatherstacks_api_demo/features/weather/domain/entities/weather.dart';

class WeatherModel extends Weather {
  WeatherModel({
    required super.temperature,
    required super.weatherCode,
    required super.weatherIcons,
    required super.weatherDescriptions,
    super.windSpeed,
    super.windDegree,
    super.windDirection,
    super.pressure,
    super.precip,
    super.humidity,
    super.cloudCover,
  });

  Map<String, dynamic> toMap() {
    return {
      'temperature': super.temperature,
      'weather_code': super.weatherCode,
      'weather_icons': super.weatherIcons,
      'weather_descriptions': super.weatherDescriptions,
      'wind_speed': super.windSpeed,
      'wind_degree': super.windDegree,
      'wind_dir': super.windDirection,
      'pressure': super.pressure,
      'precip': super.precip,
      'humidity': super.humidity,
      'cloudcover': super.cloudCover,
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      temperature: map['temperature'] as int,
      weatherCode: map['weather_code'] as int,
      weatherIcons:
          (map['weather_icons'] as List<dynamic>).map((e) => e.toString()).toList(),
      weatherDescriptions: (map['weather_descriptions'] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      windSpeed: map['wind_speed'] as int?,
      windDegree: map['wind_degree'] as int?,
      windDirection: map['wind_dir'] as String?,
      pressure: map['pressure'] as int?,
      precip: map['precip'] as int?,
      humidity: map['humidity'] as int?,
      cloudCover: map['cloudcover'] as int?,
    );
  }
}
