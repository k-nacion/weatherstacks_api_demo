import 'package:envied/envied.dart';

part 'public_env.g.dart';

@Envied(requireEnvFile: true, path: '.env')
abstract class PublicEnv {
  @EnviedField(varName: 'WEATHER_STACK_BASE_URL')
  static const weatherStackBaseUrl = _PublicEnv.weatherStackBaseUrl;
}
