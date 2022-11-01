import 'package:flutter_test/flutter_test.dart';
import 'package:weatherstacks_api_demo/features/weather/data/model/wind_model.dart';

void main() {
  group('WindModel', () {
    const tWindModelMap = {'speed': 1.0, 'deg': 1, 'gust': 1.0};
    const tWindModel = WindModel(speed: 1, deg: 1, gust: 1);

    group('toMap', () {
      test(
        'should serialize a WindModel',
        () async => expect(tWindModel.toJson(), tWindModelMap),
      );
    });

    group('fromMap', () {
      test(
        'should deserialize a WindModel',
        () async => expect(WindModel.fromJson(tWindModelMap), tWindModel),
      );
    });
  });
}
