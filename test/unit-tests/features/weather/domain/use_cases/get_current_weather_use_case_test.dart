import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weatherstacks_api_demo/error/failures.dart';
import 'package:weatherstacks_api_demo/features/weather/data/model/weather_model.dart';
import 'package:weatherstacks_api_demo/features/weather/domain/entities/weather.dart';
import 'package:weatherstacks_api_demo/features/weather/domain/repositories/weather_repository.dart';
import 'package:weatherstacks_api_demo/features/weather/domain/use_cases/get_current_weather_use_case.dart';

import '../../../../../fixture/fixture.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  group('GetCurrentWeatherUseCase', () {
    late MockWeatherRepository mockWeatherRepository;
    late GetCurrentWeatherUseCase sut;

    setUp(() {
      mockWeatherRepository = MockWeatherRepository();
      sut = GetCurrentWeatherUseCase(repository: mockWeatherRepository);
    });

    const tWeatherLocation = 'Taguig';

    test(
      'should only call one method from the repository as this will serve as delegate method/class',
      () async {
        final fromFixture = fixture('current_weather_success_response.json');
        final decodedFixture = jsonDecode(fromFixture) as Map<String, dynamic>;
        final weather = WeatherModel.fromMap(decodedFixture['current']);
        final Either<Failure, Weather> successResult = Either<Failure, Weather>.of(weather);
        when(() => mockWeatherRepository.getCurrentWeather(tWeatherLocation)).thenAnswer((_) async => successResult);

        final actual = await sut(tWeatherLocation);

        expect(actual, successResult);
        verify(() => mockWeatherRepository.getCurrentWeather(tWeatherLocation)).called(1);
      },
    );
  });
}
