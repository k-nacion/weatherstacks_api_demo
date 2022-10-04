import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weatherstacks_api_demo/core/network/network_info.dart';
import 'package:weatherstacks_api_demo/features/weather/data/data_source/weather_local_data_source.dart';
import 'package:weatherstacks_api_demo/features/weather/data/data_source/weather_remote_data_source.dart';
import 'package:weatherstacks_api_demo/features/weather/data/model/weather_model.dart';
import 'package:weatherstacks_api_demo/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weatherstacks_api_demo/features/weather/domain/entities/weather.dart';

import '../../../../../fixture/fixture.dart';

class MockWeatherLocalDataSource extends Mock implements WeatherLocalDataSource {}

class MockWeatherRemoteDataSource extends Mock implements WeatherRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  group('WeatherRepositoryImpl', () {
    late WeatherRepositoryImpl sut;
    late MockWeatherLocalDataSource mockWeatherLocalDataSource;
    late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
    late MockNetworkInfo mockNetworkInfo;

    setUp(() {
      mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
      mockWeatherLocalDataSource = MockWeatherLocalDataSource();
      mockNetworkInfo = MockNetworkInfo();
      sut = WeatherRepositoryImpl(
        localDataSource: mockWeatherLocalDataSource,
        remoteDataSource: mockWeatherRemoteDataSource,
        networkInfo: mockNetworkInfo,
      );
    });

    group('getCurrentWeather', () {
      void runOnline(void Function() body) {
        setUp(() {
          when(() => mockNetworkInfo.hasInternetConnection).thenAnswer((_) async => true);
        });

        body();
      }

      void runOffline(void Function() body) {
        setUp(() {
          when(() => mockNetworkInfo.hasInternetConnection).thenAnswer((_) async => false);
        });

        body();
      }

      const tWeatherLocation = 'Taguig';

      const tWeather = Weather(
          temperature: 13,
          weatherCode: 113,
          weatherIcons: ['https://assets.weatherstack.com/images/wsymbols01_png_64/wsymbol_0001_sunny.png'],
          weatherDescriptions: ['Sunny'],
          windSpeed: 0,
          windDegree: 349,
          windDirection: 'N',
          pressure: 1010,
          precip: 0,
          humidity: 90,
          cloudCover: 0);

      final tWeatherSuccess = WeatherModel.fromMap(jsonDecode(fixture('current_weather_success_response.json'))['current']);

      runOnline(() {
        test(
          'should check if the device is online',
          () async {
            when(() => mockWeatherRemoteDataSource.getCurrentWeather(tWeatherLocation)).thenAnswer((_) async => tWeatherSuccess);

            await sut.getCurrentWeather(tWeatherLocation);

            expect(await mockNetworkInfo.hasInternetConnection, true);
            verify(() => mockNetworkInfo.hasInternetConnection).called(1);
          },
        );

        test(
          'should fetch weather data successfully.',
          () async {
            when(() => mockWeatherRemoteDataSource.getCurrentWeather(tWeatherLocation)).thenAnswer((_) async => tWeatherSuccess);

            final actual = await sut.getCurrentWeather(tWeatherLocation);

            expect(actual, tWeatherSuccess);
            expect(await mockNetworkInfo.hasInternetConnection, true);
            verify(() => mockNetworkInfo.hasInternetConnection);
            verify(() => mockWeatherRemoteDataSource.getCurrentWeather(tWeatherLocation));
          },
        );
      });
    });
  });
}
