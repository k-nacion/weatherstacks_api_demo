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
          when(() => mockSharedPreferences.setString(Env.weatherSharedPrefKey, tSerializedWeather))
              .thenAnswer((_) async => true);

          await sut.cacheWeather(tWeatherModel);

          expect(
              await mockSharedPreferences.setString(Env.weatherSharedPrefKey, tSerializedWeather),
              true);
          verify(
              () => mockSharedPreferences.setString(Env.weatherSharedPrefKey, tSerializedWeather));
        },
      );

      test(
        'should be unable to cache the data in shared preferences package and throw an error',
        () async {
          when(() => mockSharedPreferences.setString(Env.weatherSharedPrefKey, tSerializedWeather))
              .thenAnswer((_) async => false);

          void functionToTest() async => await sut.cacheWeather(tWeatherModel);

          expect(
              await mockSharedPreferences.setString(Env.weatherSharedPrefKey, tSerializedWeather),
              false);
          expect(functionToTest, throwsA(isA<CacheException>()));
        },
      );
    });
  });
}
