import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final int temperature;
  final int weatherCode;
  final List<String> weatherIcons;
  final List<String> weatherDescriptions;
  final int? windSpeed;
  final int? windDegree;
  final String? windDirection;
  final int? pressure;
  final int? precip;
  final int? humidity;
  final int? cloudCover;

  const Weather({
    required this.temperature,
    required this.weatherCode,
    required this.weatherIcons,
    required this.weatherDescriptions,
    this.windSpeed,
    this.windDegree,
    this.windDirection,
    this.pressure,
    this.precip,
    this.humidity,
    this.cloudCover,
  });

  @override
  String toString() {
    return 'Weather{temperature: $temperature, weatherCode: $weatherCode, weatherIcons: $weatherIcons, weatherDescriptions: $weatherDescriptions, windSpeed: $windSpeed, windDegree: $windDegree, windDirection: $windDirection, pressure: $pressure, precip: $precip, humidity: $humidity, cloudCover: $cloudCover}';
  }

  @override
  List<Object?> get props => [
        temperature,
        weatherCode,
        weatherIcons,
        weatherDescriptions,
        windSpeed,
        windDegree,
        windDirection,
        pressure,
        precip,
        humidity,
        cloudCover,
      ];
}
