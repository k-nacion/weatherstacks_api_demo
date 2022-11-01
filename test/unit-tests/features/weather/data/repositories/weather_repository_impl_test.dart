import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weatherstacks_api_demo/error/exceptions.dart';
import 'package:weatherstacks_api_demo/error/failures.dart';
import 'package:weatherstacks_api_demo/features/weather/data/data_source/network_info.dart';
import 'package:weatherstacks_api_demo/features/weather/data/data_source/weather_local_data_source.dart';
import 'package:weatherstacks_api_demo/features/weather/data/data_source/weather_remote_data_source.dart';
import 'package:weatherstacks_api_demo/features/weather/data/model/coordinates_model.dart';
import 'package:weatherstacks_api_demo/features/weather/data/model/weather_model.dart';
import 'package:weatherstacks_api_demo/features/weather/data/model/weather_model2.dart';
import 'package:weatherstacks_api_demo/features/weather/data/model/wind_model.dart';
import 'package:weatherstacks_api_demo/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weatherstacks_api_demo/features/weather/domain/entities/coordinates.dart';
import 'package:weatherstacks_api_demo/features/weather/domain/entities/weather2.dart';

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

    void runOnline(void Function() body) {
      group('Running ONLINE', () {
        setUp(() {
          when(() => mockNetworkInfo.hasInternet).thenAnswer((_) async => true);
        });

        body();
      });
    }

    void runOffline(void Function() body) {
      group('Running OFFLINE', () {
        setUp(() {
          when(() => mockNetworkInfo.hasInternet).thenAnswer((_) async => false);
        });

        body();
      });
    }

    group('getCurrentWeather', () {
      const tWeatherLocation = 'Taguig';

      final tWeatherSuccess = WeatherModel.fromMap(
          jsonDecode(fixture('current_weather_success_response.json'))['current']);

      runOnline(() {
        test(
          'should check if the device is online',
          () async {
            when(() => mockWeatherRemoteDataSource.getCurrentWeather(tWeatherLocation))
                .thenAnswer((_) async => tWeatherSuccess);
            when(() => mockWeatherLocalDataSource.cacheWeather(tWeatherSuccess))
                .thenAnswer((_) async {});

            await sut.getCurrentWeather(tWeatherLocation);

            verify(() => mockNetworkInfo.hasInternet).called(1);
          },
        );

        test(
          'should fetch weather data successfully.',
          () async {
            when(() => mockWeatherRemoteDataSource.getCurrentWeather(tWeatherLocation))
                .thenAnswer((_) async => tWeatherSuccess);
            when(() => mockWeatherLocalDataSource.cacheWeather(tWeatherSuccess))
                .thenAnswer((_) async {});

            final actual = await sut.getCurrentWeather(tWeatherLocation);

            expect(actual, Right(tWeatherSuccess));
            expect(await mockNetworkInfo.hasInternet, true);
            verify(() => mockNetworkInfo.hasInternet);
            verify(() => mockWeatherRemoteDataSource.getCurrentWeather(tWeatherLocation));
          },
        );

        test(
          'remote data source should throw an ServerUnreachableException',
          () async {
            when(() => mockWeatherRemoteDataSource.getCurrentWeather(tWeatherLocation))
                .thenThrow(ServerUnreachableException());

            final actual = await sut.getCurrentWeather(tWeatherLocation);

            verify(() => mockNetworkInfo.hasInternet).called(1);
            expect(actual, Left(ServerUnreachableFailure()));
            verify(() => mockWeatherRemoteDataSource.getCurrentWeather(tWeatherLocation));
          },
        );

        test(
          'should cache the raw data before returning the value.',
          () async {
            when(() => mockWeatherRemoteDataSource.getCurrentWeather(tWeatherLocation))
                .thenAnswer((_) async => tWeatherSuccess);
            when(() => mockWeatherLocalDataSource.cacheWeather(tWeatherSuccess))
                .thenAnswer((_) async {});

            await sut.getCurrentWeather(tWeatherLocation);

            verify(() => mockNetworkInfo.hasInternet);
            expect(await mockNetworkInfo.hasInternet, true);
            verify(() => mockWeatherLocalDataSource.cacheWeather(tWeatherSuccess));
          },
        );
      });

      runOffline(() {
        test(
          'should return the last cached weather if the device is offline',
          () async {
            when(() => mockWeatherLocalDataSource.getLastCachedWeatherData())
                .thenAnswer((_) async => tWeatherSuccess);

            final actual = await sut.getCurrentWeather(tWeatherLocation);

            expect(actual, Right(tWeatherSuccess));
          },
        );

        test(
          'should return CacheFailure when unable to get cached data.',
          () async {
            when(() => mockWeatherLocalDataSource.getLastCachedWeatherData())
                .thenThrow(CacheException());

            final actual = await sut.getCurrentWeather(tWeatherLocation);

            expect(actual, Left(CacheFailure()));
            expect(await mockNetworkInfo.hasInternet, false);
          },
        );
      });
    });

    group('getCurrentWeatherFromOpenWeatherApi', () {
      const tCoordinates = Coordinates(latitude: 14.93, longitude: 120.48);

      final openWeatherApi = jsonDecode(fixture('openweatherapi_success.json'));
      final parsedCoordinates = openWeatherApi['coord'];
      final parsedWeather = openWeatherApi['weather'];
      final parsedMain = openWeatherApi['main'];
      final parsedWind = openWeatherApi['wind'];
      final parsedSystem = openWeatherApi['sys'];

      final tWeather2 = WeatherModel2(
        coord: CoordinatesModel.fromJson(parsedCoordinates),
        wind: WindModel.fromJson(parsedWind),
        weatherId: parsedWeather['id'] as int,
        weatherMain: parsedWeather['main'] as String,
        weatherDescription: parsedWeather['description'] as String,
        weatherIcon: parsedWeather['icon'] as String,
        temp: parsedMain['temp'] as double,
        feelsLike: parsedMain['feels_like'] as double,
        tempMin: parsedMain['temp_min'] as double,
        tempMax: parsedMain['temp_max'] as double,
        pressure: parsedMain['pressure'] as int,
        dt: openWeatherApi['dt'] as int,
        sunriseTime: parsedSystem['sunrise'] as int,
        sunsetTime: parsedSystem['sunset'] as int,
      );

      final Either<Failure, Weather2> tWeatherSuccess = Right(tWeather2);

      runOnline(() {
        test(
          'should return successfully a weather2 model',
          () async {
            when(() => mockWeatherRemoteDataSource.getWeatherFromOpenWeatherApi(tCoordinates))
                .thenAnswer((_) async => tWeather2);

            final actual = await sut.getCurrentWeatherFromOpenWeatherApi(tCoordinates);

            expect(actual, tWeatherSuccess);
            verify(() => mockWeatherRemoteDataSource.getWeatherFromOpenWeatherApi(tCoordinates));
          },
        );
      });
    });
  });
}
