part of 'weather_bloc.dart';

class WeatherState extends Union4Impl<Initial, Loading, OnFailure, OnSuccess> {
  static const unions = Quartet<Initial, Loading, OnFailure, OnSuccess>();

  WeatherState._(Union4<Initial, Loading, OnFailure, OnSuccess> union) : super(union);

  factory WeatherState.initial() => WeatherState._(unions.first(const Initial()));

  factory WeatherState.onLoading() => WeatherState._(unions.second(const Loading()));

  factory WeatherState.onFailure({String? message}) =>
      WeatherState._(unions.third(OnFailure(message: message)));

  factory WeatherState.onSuccess({required Weather weather}) =>
      WeatherState._(unions.fourth(OnSuccess(weather: weather)));
}

class Initial extends Equatable {
  const Initial();

  @override
  List<Object?> get props => [];
}

class Loading extends Equatable {
  const Loading();

  @override
  List<Object> get props => [];
}

class OnFailure extends Equatable {
  final String? message;

  const OnFailure({
    this.message,
  });

  @override
  List<Object> get props => [];
}

class OnSuccess extends Equatable {
  final Weather weather;

  const OnSuccess({
    required this.weather,
  });

  @override
  List<Object> get props => [weather];
}
