import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherstacks_api_demo/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weatherstacks_api_demo/features/weather/presentation/widgets/weather_app_bar.dart';
import 'package:weatherstacks_api_demo/features/weather/presentation/widgets/weather_current_date.dart';
import 'package:weatherstacks_api_demo/features/weather/presentation/widgets/weather_current_temp.dart';
import 'package:weatherstacks_api_demo/features/weather/presentation/widgets/weather_more_info.dart';
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const WeatherAppBar(),
                const WeatherCurrentDate(),
                Divider(
                  color: Theme.of(context).textTheme.headlineMedium?.color,
                  thickness: 3,
                  indent: 8,
                  endIndent: 8,
                ),
                const Expanded(child: WeatherCurrentTemp()),
                Divider(
                  color: Theme.of(context).textTheme.headlineMedium?.color,
                  thickness: 3,
                  indent: 8,
                  endIndent: 8,
                ),
                const WeatherMoreInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
