import 'package:equatable/equatable.dart';
import 'package:weatherstacks_api_demo/features/weather/domain/entities/coordinates.dart';
import 'package:weatherstacks_api_demo/features/weather/domain/entities/wind.dart';

class Weather2 extends Equatable {
  final Coordinates coord;
  final Wind wind;

  final int weatherId;
  final String weatherMain;
  final String weatherDescription;
  final String weatherIcon;

  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;

  final int dt;
  final int sunriseTime;
  final int sunsetTime;

  const Weather2({
    required this.coord,
    required this.wind,
    required this.weatherId,
    required this.weatherMain,
    required this.weatherDescription,
    required this.weatherIcon,
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.dt,
    required this.sunriseTime,
    required this.sunsetTime,
  });

  @override
  List<Object> get props => [
        coord,
        wind,
        weatherId,
        weatherMain,
        weatherDescription,
        weatherIcon,
        temp,
        feelsLike,
        tempMin,
        tempMax,
        pressure,
        dt,
        sunriseTime,
        sunsetTime,
      ];
}
