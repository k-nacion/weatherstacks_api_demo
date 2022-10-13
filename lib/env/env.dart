import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(requireEnvFile: true)
abstract class Env {
  @EnviedField()
  static const WEATHER_STACK_BASE_URL = _Env.WEATHER_STACK_BASE_URL;
  @EnviedField()
  static const WEATHER_STACK_BASE_URL_UNENCODED_PATH = _Env.WEATHER_STACK_BASE_URL_UNENCODED_PATH;
  @EnviedField()
  static const WEATHER_STACK_BASE_URL_ACESS_KEY_QUERY = _Env.WEATHER_STACK_BASE_URL_ACESS_KEY_QUERY;
  @EnviedField()
  static const WEATHER_STACK_BASE_URL_QUERY_QUERY = _Env.WEATHER_STACK_BASE_URL_QUERY_QUERY;
  @EnviedField()
  static const WEATHER_SHARED_PREF_KEY = _Env.WEATHER_SHARED_PREF_KEY;
  @EnviedField()
  static const SUCCESS_JSON_RESPONSE = _Env.SUCCESS_JSON_RESPONSE;
  @EnviedField()
  static const WEATHER_URI_HEADER = _Env.WEATHER_URI_HEADER;
}
