import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherstacks_api_demo/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weatherstacks_api_demo/features/weather/presentation/widgets/weather_app_bar.dart';
import 'package:weatherstacks_api_demo/features/weather/weather_di.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherBloc>(
      create: (context) => sl<WeatherBloc>(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SafeArea(
            child: Column(
              children: const [
                WeatherAppBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
