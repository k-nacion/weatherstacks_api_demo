import 'package:envied/envied.dart';
import 'package:weatherstacks_api_demo/env/private_env.dart';

part 'public_env.g.dart';

@Envied(requireEnvFile: true, path: '.env')
abstract class PublicEnv {
  @EnviedField(varName: 'WEATHER_STACK_BASE_URL')
  static final weatherStackBaseUrl = _PublicEnv.weatherStackBaseUrl;
}
