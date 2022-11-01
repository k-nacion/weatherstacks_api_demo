import 'package:equatable/equatable.dart';

class Coordinates extends Equatable {
  final double longitude;
  final double latitude;

  const Coordinates({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object> get props => [latitude, longitude];
}
