import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weatherstacks_api_demo/features/weather/data/model/coordinates_model.dart';
import 'package:weatherstacks_api_demo/features/weather/data/model/wind_model.dart';
import 'package:weatherstacks_api_demo/features/weather/domain/entities/weather2.dart';

part 'weather_model2.g.dart';

@JsonSerializable(explicitToJson: true)
class WeatherModel2 extends Weather2 {
  final CoordinatesModel coord;
  final WindModel wind;

  @JsonKey(name: 'id')
  final int weatherId;
  @JsonKey(name: 'main')
  final String weatherMain;
  @JsonKey(name: 'description')
  final String weatherDescription;
  @JsonKey(name: 'icon')
  final String weatherIcon;

  @JsonKey(name: 'temp')
  final double temp;
  @JsonKey(name: 'feels_like')
  final double feelsLike;
  @JsonKey(name: 'temp_min')
  final double tempMin;
  @JsonKey(name: 'temp_max')
  final double tempMax;
  final int pressure;

  final int dt;
  @JsonKey(name: 'sunrise')
  final int sunriseTime;
  @JsonKey(name: 'sunset')
  final int sunsetTime;

  const WeatherModel2(
      {required this.coord,
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
      required this.sunsetTime})
      : super(
          wind: wind,
          coord: coord,
          dt: dt,
          feelsLike: feelsLike,
          pressure: pressure,
          sunriseTime: sunriseTime,
          sunsetTime: sunsetTime,
          temp: temp,
          tempMax: tempMax,
          tempMin: tempMin,
          weatherDescription: weatherDescription,
          weatherIcon: weatherIcon,
          weatherId: weatherId,
          weatherMain: weatherMain,
        );

  factory WeatherModel2.fromJson(Map<String, dynamic> json) => _$WeatherModel2FromJson(json);

  Map<String, dynamic> toJson() => _$WeatherModel2ToJson(this);
}
