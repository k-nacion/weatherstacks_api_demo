import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weatherstacks_api_demo/env/env.dart';
import 'package:weatherstacks_api_demo/error/failures.dart';
import 'package:weatherstacks_api_demo/features/weather/data/model/weather_model.dart';
import 'package:weatherstacks_api_demo/features/weather/domain/entities/weather.dart';
import 'package:weatherstacks_api_demo/features/weather/domain/use_cases/get_current_weather_use_case.dart';
import 'package:weatherstacks_api_demo/features/weather/presentation/bloc/weather_bloc.dart';

import '../../../../../fixture/fixture.dart';

class MockGetCurrentWeatherUseCase extends Mock implements GetCurrentWeatherUseCase {}

void main() {
  group('WeatherBlocTest', () {
    late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
    late WeatherBloc sut;

    setUp(() {
      mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
      sut = WeatherBloc(getCurrentWeatherUseCase: mockGetCurrentWeatherUseCase);
    });

    group('events', () {
      const tWeatherLocation = 'Taguig';

      final tWeather =
          WeatherModel.fromMap(jsonDecode(fixture(Env.SUCCESS_JSON_RESPONSE))['current']);
      final Either<Failure, Weather> tSuccessWeather = Right(tWeather);
      const Either<Failure, Weather> tCacheFailure =
          Left(CacheFailure(message: Env.WEATHER_CACHE_ERROR_MESSAGE));
      const Either<Failure, Weather> tServerUncreachableFailure =
          Left(ServerUnreachableFailure(message: Env.WEATHER_SERVER_UNREACHABLE_ERROR_MESSAGE));
      const Either<Failure, Weather> tNoInternetFailure =
          Left(ServerUnreachableFailure(message: Env.WEATHER_NO_INTERNET_ERROR_MESSAGE));
      const tGetCurrentWeatherEvent = WeatherGetCurrentEvent(location: tWeatherLocation);

      group('Get Current Weather', () {
        void getCurrentWeatherTemplate({
          required void Function() initWhenStatement,
          required List<WeatherState> expectedState,
        }) async {
          initWhenStatement();

          expect(sut.stream.asBroadcastStream(), emitsInOrder(expectedState));
          sut.add(tGetCurrentWeatherEvent);
          await untilCalled(() => mockGetCurrentWeatherUseCase.call(any()));
          verify(() => mockGetCurrentWeatherUseCase.call(tWeatherLocation));
        }

        test(
          'should emit [onLoading -> onSuccess] if successful.',
          () {
            getCurrentWeatherTemplate(
                initWhenStatement: () {
                  when(() => mockGetCurrentWeatherUseCase.call(tWeatherLocation))
                      .thenAnswer((_) async => tSuccessWeather);
                },
                expectedState: [
                  WeatherState.onLoading(),
                  WeatherState.onSuccess(weather: tWeather)
                ]);
          },
        );

        test('should emit [loading -> onFailure] but CacheException was thrown', () async {
          getCurrentWeatherTemplate(
              initWhenStatement: () {
                when(() => mockGetCurrentWeatherUseCase.call(tWeatherLocation))
                    .thenAnswer((_) async => tCacheFailure);
              },
              expectedState: [
                WeatherState.onLoading(),
                WeatherState.onFailure(message: Env.WEATHER_CACHE_ERROR_MESSAGE)
              ]);
        });

        test(
          'should emit [onLoading -> onFailure] but ServerUnreachable was thrown.',
          () async {
            getCurrentWeatherTemplate(
                initWhenStatement: () {
                  when(() => mockGetCurrentWeatherUseCase.call(tWeatherLocation))
                      .thenAnswer((_) async => tServerUncreachableFailure);
                },
                expectedState: [
                  WeatherState.onLoading(),
                  WeatherState.onFailure(message: Env.WEATHER_SERVER_UNREACHABLE_ERROR_MESSAGE)
                ]);
          },
        );

        test(
          'should emit [onLoading -> onFailure] but NoInternetException was thrown',
          () async {
            getCurrentWeatherTemplate(
                initWhenStatement: () {
                  when(() => mockGetCurrentWeatherUseCase.call(tWeatherLocation))
                      .thenAnswer((_) async => tNoInternetFailure);
                },
                expectedState: [
                  WeatherState.onLoading(),
                  WeatherState.onFailure(message: Env.WEATHER_NO_INTERNET_ERROR_MESSAGE)
                ]);
          },
        );
      });
    });
  });
}
