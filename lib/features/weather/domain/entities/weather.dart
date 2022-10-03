import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  ///	Returns the temperature in the selected unit. (Default: Celsius)
  final int temperature;

  /// Returns the universal weather condition code associated with the current weather condition. You can download all available weather codes using this link: Download Weather Codes (ZIP file)
  ///
  /// @Link [https://weatherstack.com/site_resources/weatherstack-weather-condition-codes.zip]

  final int weatherCode;

  /// Returns one or more PNG weather icons associated with the current weather condition.
  final List<String> weatherIcons;

  ///Returns one or more weather description texts associated with the current weather condition.
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
