import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherstacks_api_demo/env/env.dart';
import 'package:weatherstacks_api_demo/error/exceptions.dart';
import 'package:weatherstacks_api_demo/features/weather/data/data_source/weather_local_data_source.dart';
import 'package:weatherstacks_api_demo/features/weather/data/model/weather_model.dart';

import '../../../../../fixture/fixture.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('Weather Local Data Source Impl', () {
    late WeatherLocalDataSourceImpl sut;
    late MockSharedPreferences mockSharedPreferences;

    setUp(() {
      mockSharedPreferences = MockSharedPreferences();
      sut = WeatherLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
    });

    final tWeatherModel = WeatherModel.fromMap(
        jsonDecode(fixture('current_weather_success_response.json'))['current']);

    final tSerializedWeather = jsonEncode(tWeatherModel.toMap());

    group('cacheWeather(WeatherModel weather)', () {
      test(
        'should cache the data in the shared preferences package and be successful.',
        () async {
          when(() =>
                  mockSharedPreferences.setString(Env.WEATHER_SHARED_PREF_KEY, tSerializedWeather))
              .thenAnswer((_) async => true);

          await sut.cacheWeather(tWeatherModel);

          expect(
              await mockSharedPreferences.setString(
                  Env.WEATHER_SHARED_PREF_KEY, tSerializedWeather),
              true);
          verify(() =>
              mockSharedPreferences.setString(Env.WEATHER_SHARED_PREF_KEY, tSerializedWeather));
        },
      );

      test(
        'should be unable to cache the data in shared preferences package and throw an error',
        () async {
          when(() =>
                  mockSharedPreferences.setString(Env.WEATHER_SHARED_PREF_KEY, tSerializedWeather))
              .thenAnswer((_) async => false);

          void functionToTest() async => await sut.cacheWeather(tWeatherModel);

          expect(
              await mockSharedPreferences.setString(
                  Env.WEATHER_SHARED_PREF_KEY, tSerializedWeather),
              false);
          expect(functionToTest, throwsA(isA<CacheException>()));
        },
      );
    });

    group('getlastCachedWeatherData()', () {
      test(
        'should be able to get the last cached weather data successfully. ',
        () async {
          when(() => mockSharedPreferences.getString(Env.WEATHER_SHARED_PREF_KEY))
              .thenReturn(tSerializedWeather);

          final actual = await sut.getLastCachedWeatherData();

          expect(actual, tWeatherModel);
          verify(() => mockSharedPreferences.getString(Env.WEATHER_SHARED_PREF_KEY));
        },
      );

      test(
        'Should throw CacheException when cached data is null',
        () async {
          when(() => mockSharedPreferences.getString(Env.WEATHER_SHARED_PREF_KEY)).thenReturn(null);

          void functionToTest() async => await sut.getLastCachedWeatherData();

          expect(functionToTest, throwsA(isA<CacheException>()));
          verify(() => mockSharedPreferences.getString(Env.WEATHER_SHARED_PREF_KEY));
        },
      );

      test(
        'should throw CacheException when cached data empty string',
        () async {
          when(() => mockSharedPreferences.getString(Env.WEATHER_SHARED_PREF_KEY)).thenReturn('');

          void functionToTest() async => await sut.getLastCachedWeatherData();

          expect(functionToTest, throwsA(isA<CacheException>()));
        },
      );
    });
  });
}
