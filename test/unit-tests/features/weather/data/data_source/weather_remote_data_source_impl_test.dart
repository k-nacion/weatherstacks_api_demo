import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weatherstacks_api_demo/env/env.dart';
import 'package:weatherstacks_api_demo/env/private_env.dart';
import 'package:weatherstacks_api_demo/error/exceptions.dart';
import 'package:weatherstacks_api_demo/features/weather/data/data_source/weather_remote_data_source.dart';
import 'package:weatherstacks_api_demo/features/weather/data/model/weather_model.dart';

import '../../../../../fixture/fixture.dart';

class MockClient extends Mock implements Client {}

void main() {
  group('weather_remote_data_source_impl.dart', () {
    late MockClient mockClient;
    late WeatherRemoteDataSourceImpl sut;

    setUp(() {
      mockClient = MockClient();
      sut = WeatherRemoteDataSourceImpl(httpClient: mockClient);
    });

    const tWeatherLocation = 'Taguig';
    final tWeatherModelParsed =
        WeatherModel.fromMap(jsonDecode(fixture(Env.SUCCESS_JSON_RESPONSE))['current']);
    final tUriQueries = {
      Env.WEATHER_STACK_BASE_URL_ACCESS_KEY_QUERY: PrivateEnv.weatherStackApiKey,
      Env.WEATHER_STACK_BASE_URL_QUERY_QUERY: tWeatherLocation
    };
    final tUri = Uri.http(
        Env.WEATHER_STACK_BASE_URL, Env.WEATHER_STACK_BASE_URL_UNENCODED_PATH, tUriQueries);

    group('getCurrentWeather', () {
      test(
        'should return successfully a WeatherModel with no errors',
        () async {
          when(() => mockClient.read(tUri, headers: weatherUriHeader))
              .thenAnswer((_) async => fixture(Env.SUCCESS_JSON_RESPONSE));

          final actual = await sut.getCurrentWeather(tWeatherLocation);

          expect(actual, tWeatherModelParsed);
          verify(() => mockClient.read(tUri, headers: weatherUriHeader));
        },
      );

      test(
        'should throw a SeverUnreachableException when an error during GET Request',
        () async {
          when(() => mockClient.read(tUri, headers: weatherUriHeader))
              .thenThrow(ClientException(''));

          void functionToTest() async => await sut.getCurrentWeather(tWeatherLocation);

          expect(functionToTest, throwsA(isA<ServerUnreachableException>()));
          verify(() => mockClient.read(tUri, headers: weatherUriHeader));
        },
      );
    });
  });
}
