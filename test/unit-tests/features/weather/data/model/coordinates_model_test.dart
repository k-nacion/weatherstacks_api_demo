import 'package:flutter_test/flutter_test.dart';
import 'package:weatherstacks_api_demo/features/weather/data/model/coordinates_model.dart';

void main() {
  group('CoordinatesModel', () {
    const tCoordinatesModelMap = {'lon': 1.2, 'lat': 1.0};
    const tCoordinatesModel = CoordinatesModel(longitude: 1.2, latitude: 1);

    group('toMap', () {
      test(
        'should return expected toMap result',
        () async => expect(tCoordinatesModel.toJson(), tCoordinatesModelMap),
      );
    });

    group('fromMap', () {
      test(
        'should return a map from an existing location model class ',
        () async => expect(CoordinatesModel.fromJson(tCoordinatesModelMap), tCoordinatesModel),
      );
    });
  });
}
