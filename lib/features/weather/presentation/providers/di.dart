part of 'weather_provider.dart';

final _internetConnectionCheckerProvider = Provider<InternetConnectionChecker>((ref) {
  return InternetConnectionChecker();
});

final _sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

final _httpClientProvider = Provider<Client>((ref) {
  return Client();
});

final _networkInfoProvider = Provider<NetworkInfo>((ref) {
  return NetworkInfoImpl(internetConnectionChecker: ref.read(_internetConnectionCheckerProvider));
});

final _weatherLocalDataSourceProvider = Provider<WeatherLocalDataSource>((ref) {
  final sharedPref = ref.read(_sharedPreferencesProvider);

  return WeatherLocalDataSourceImpl(sharedPreferences: sharedPref.value!);
});

final _weatherRemoteDataSourceProvider = Provider<WeatherRemoteDataSource>((ref) {
  return WeatherRemoteDataSourceImpl(httpClient: ref.read((_httpClientProvider)));
});

final _weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  final localDataSource = ref.read(_weatherLocalDataSourceProvider);
  final remoteDataSource = ref.read(_weatherRemoteDataSourceProvider);
  final networkInfo = ref.read(_networkInfoProvider);

  return WeatherRepositoryImpl(
    localDataSource: localDataSource,
    networkInfo: networkInfo,
    remoteDataSource: remoteDataSource,
  );
});

final _getCurrentWeatherUseCaseProvider = Provider<GetCurrentWeatherUseCase>((ref) {
  return GetCurrentWeatherUseCase(repository: ref.read(_weatherRepositoryProvider));
});
