import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weatherstacks_api_demo/features/weather/domain/entities/wind.dart';

part 'wind_model.g.dart';

@JsonSerializable()
class WindModel extends Wind {
  const WindModel({
    required super.speed,
    required super.deg,
    required super.gust,
  });

  factory WindModel.fromJson(Map<String, dynamic> json) => _$WindModelFromJson(json);

  Map<String, dynamic> toJson() => _$WindModelToJson(this);
}
