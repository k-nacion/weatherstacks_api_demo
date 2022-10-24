part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class WeatherGetCurrentEvent extends WeatherEvent {
  final String location;

  const WeatherGetCurrentEvent({
    required this.location,
  });

  @override
  List<Object> get props => [location];
}
