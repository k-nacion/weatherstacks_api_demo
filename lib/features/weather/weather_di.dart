import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherstacks_api_demo/features/weather/data/data_source/network_info.dart';
import 'package:weatherstacks_api_demo/features/weather/data/data_source/weather_local_data_source.dart';
import 'package:weatherstacks_api_demo/features/weather/data/data_source/weather_remote_data_source.dart';
import 'package:weatherstacks_api_demo/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weatherstacks_api_demo/features/weather/domain/repositories/weather_repository.dart';
import 'package:weatherstacks_api_demo/features/weather/domain/use_cases/get_current_weather_use_case.dart';
import 'package:weatherstacks_api_demo/features/weather/presentation/bloc/weather_bloc.dart';

final sl = GetIt.instance;

FutureOr<void> weatherDiInit() async {
  //bloc
  sl.registerFactory<WeatherBloc>(() => WeatherBloc(
        getCurrentWeatherUseCase: sl<GetCurrentWeatherUseCase>(),
      ));

  //usecase
  sl.registerLazySingleton<GetCurrentWeatherUseCase>(
      () => GetCurrentWeatherUseCase(repository: sl<WeatherRepository>()));

  //repository
  sl.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(
      localDataSource: sl<WeatherLocalDataSource>(),
      remoteDataSource: sl<WeatherRemoteDataSource>(),
      networkInfo: sl<NetworkInfo>()));

  //datasources
  sl.registerLazySingleton<WeatherLocalDataSource>(
      () => WeatherLocalDataSourceImpl(sharedPreferences: sl<SharedPreferences>()));
  sl.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(httpClient: sl<Client>()));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(
        internetConnectionChecker: sl<InternetConnectionChecker>(),
      ));

  //3rd party packages
  final sp = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sp);
  sl.registerLazySingleton<Client>(() => Client());
  sl.registerLazySingleton<InternetConnectionChecker>(() => InternetConnectionChecker());
}
