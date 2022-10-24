import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';
import 'package:weatherstacks_api_demo/error/failures.dart';
import 'package:weatherstacks_api_demo/features/weather/domain/entities/weather.dart';

import '../../domain/use_cases/get_current_weather_use_case.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;

  WeatherBloc({
    required GetCurrentWeatherUseCase getCurrentWeatherUseCase,
  })  : _getCurrentWeatherUseCase = getCurrentWeatherUseCase,
        super(WeatherState.initial()) {
    on<WeatherGetCurrentEvent>(_mapWeatherGetCurrentEventToState);
  }

  FutureOr<void> _mapWeatherGetCurrentEventToState(
    WeatherGetCurrentEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherState.onLoading());

    final eitherFailureOrWeather = await _getCurrentWeatherUseCase.call(event.location);

    eitherFailureOrWeather.match(
      (Failure failure) => emit(WeatherState.onFailure(message: failure.message)),
      (Weather weather) => emit(WeatherState.onSuccess(weather: weather)),
    );
  }
}
