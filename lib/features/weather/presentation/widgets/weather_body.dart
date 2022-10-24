import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';
import 'package:weatherstacks_api_demo/features/weather/presentation/bloc/weather_bloc.dart';

class WeatherBody extends StatefulWidget {
  const WeatherBody({Key? key}) : super(key: key);

  @override
  State<WeatherBody> createState() => _WeatherBodyState();
}

class _WeatherBodyState extends State<WeatherBody> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(WeatherGetCurrentEvent(location: 'taguig'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child:
            SealedBlocBuilder4<WeatherBloc, WeatherState, Initial, Loading, OnFailure, OnSuccess>(
          builder: (context, state) {
            return state(
              (initial) => _buildInitialState(),
              (onLoading) => _buildOnLoadingState(),
              (onFailure) => _buildOnFailureState(onFailure),
              (onSuccess) => _buildOnSuccess(onSuccess),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInitialState() {
    //TODO: remove this state
    return const Center(
      child: Text('No data yet!'),
    );
  }

  Widget _buildOnLoadingState() {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }

  Widget _buildOnFailureState(OnFailure onFailure) {
    return BlocListener(
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(onFailure.message!),
          ),
        );
      },
    );
  }

  Widget _buildOnSuccess(OnSuccess onSuccess) {
    return Center(
      child: Text(
        onSuccess.weather.toString(),
        style: TextStyle(fontWeight: FontWeight.normal),
      ),
    );
  }
}
