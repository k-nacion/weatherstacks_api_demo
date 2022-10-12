import 'package:envied/envied.dart';

part 'private_env.g.dart';

@Envied(path: '.private.env', requireEnvFile: true, obfuscate: true)
abstract class PrivateEnv {
  @EnviedField(varName: 'WEATHER_STACK_API_KEY')
  static final weatherStackApiKey = _PrivateEnv.weatherStackApiKey;
}
