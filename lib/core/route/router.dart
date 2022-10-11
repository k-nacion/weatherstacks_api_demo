import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weatherstacks_api_demo/features/weather/presentation/pages/weather_page.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(
    path: '/',
    name: 'home',
    pageBuilder: (context, state) => const MaterialPage(child: WeatherPage()),
  )
]);
