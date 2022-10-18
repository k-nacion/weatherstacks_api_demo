import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherstacks_api_demo/features/weather/data/data_source/network_info.dart';
import 'package:weatherstacks_api_demo/features/weather/data/data_source/weather_local_data_source.dart';
import 'package:weatherstacks_api_demo/features/weather/data/data_source/weather_remote_data_source.dart';
import 'package:weatherstacks_api_demo/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weatherstacks_api_demo/features/weather/domain/repositories/weather_repository.dart';
import 'package:weatherstacks_api_demo/features/weather/domain/use_cases/get_current_weather_use_case.dart';

part 'di.dart';
