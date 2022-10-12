import 'package:weatherstacks_api_demo/env/private_env.dart';

part 'proxy_env.g.dart';

/*
@Envied(requireEnvFile: true, path: '.env')
*/
abstract class ProxyEnv {
/*
  @EnviedField(varName: 'WEATHER_STACK_BASE_URL')
*/
  static final weatherStackBaseUrl = _ProxyEnv.weatherStackBaseUrl;
}
