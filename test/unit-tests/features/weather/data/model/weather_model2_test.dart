import 'package:flutter_test/flutter_test.dart';
import 'package:weatherstacks_api_demo/features/weather/data/model/coordinates_model.dart';
import 'package:weatherstacks_api_demo/features/weather/data/model/weather_model2.dart';
import 'package:weatherstacks_api_demo/features/weather/data/model/wind_model.dart';

void main() {
  group('WeatherModel2', () {
    const tWindModel = WindModel(speed: 1, deg: 1, gust: 1);
    const tCoordinatesModel = CoordinatesModel(longitude: 1.2, latitude: 1);

    const tWeatherModel2 = WeatherModel2(
      coord: tCoordinatesModel,
      wind: tWindModel,
      weatherId: 1,
      weatherMain: 'Rain',
      weatherDescription: 'moderate rain',
      weatherIcon: '10d',
      temp: 1,
      feelsLike: 1,
      tempMin: 1,
      tempMax: 1,
      pressure: 1,
      dt: 1,
      sunriseTime: 1,
      sunsetTime: 1,
    );

    const tWeatherModel2Map = {
      'coord': {
        'lon': 1.2,
        'lat': 1.0,
      },
      'wind': {
        'speed': 1.0,
        'deg': 1,
        'gust': 1.0,
      },
      'id': 1,
      'main': 'Rain',
      'description': 'moderate rain',
      'icon': '10d',
      'temp': 1.0,
      'feels_like': 1.0,
      'temp_min': 1.0,
      'temp_max': 1.0,
      'pressure': 1,
      'dt': 1,
      'sunrise': 1,
      'sunset': 1,
    };

    group('toMap', () {
      test(
        'should return a map of a WeatherModel2',
        () async {
          expect(tWeatherModel2.toJson(), tWeatherModel2Map);
        },
      );
    });

    group('fromJson', () {
      test(
        'should create an instance of WeatherModel2 from json',
        () async {
          expect(WeatherModel2.fromJson(tWeatherModel2Map), tWeatherModel2);
        },
      );
    });
  });
}
