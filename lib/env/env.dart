import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(obfuscate: true, varName: 'WEATHER_STACK_API_KEY')
  static final weatherstackApiKey = _Env.weatherstackApiKey;
}
