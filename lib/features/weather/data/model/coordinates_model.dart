import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weatherstacks_api_demo/features/weather/domain/entities/coordinates.dart';

part 'coordinates_model.g.dart';

@JsonSerializable()
class CoordinatesModel extends Coordinates {
  @JsonKey(name: 'lon')
  final double longitude;

  @JsonKey(name: 'lat')
  final double latitude;

  const CoordinatesModel({
    required this.longitude,
    required this.latitude,
  }) : super(latitude: latitude, longitude: longitude);

  factory CoordinatesModel.fromJson(Map<String, dynamic> json) => _$CoordinatesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesModelToJson(this);
}
