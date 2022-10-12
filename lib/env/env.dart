import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(requireEnvFile: true)
abstract class Env {
  @EnviedField(varName: 'WEATHER_SHARED_PREF_KEY')
  static const weatherSharedPrefKey = _Env.weatherSharedPrefKey;
}
