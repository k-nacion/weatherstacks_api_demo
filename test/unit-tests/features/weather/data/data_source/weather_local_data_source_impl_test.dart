import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherstacks_api_demo/features/weather/data/data_source/weather_local_data_source.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('Weather Local Data Source Impl', () {
    late WeatherLocalDataSourceImpl sut;
    late MockSharedPreferences mockSharedPreferences;

    setUp(() {
      mockSharedPreferences = MockSharedPreferences();
      sut = WeatherLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
    });

    group('cacheWeather(WeatherModel weather)', () {
      test(
        'should cache the data ',
        () async {},
      );
    });
  });
}
