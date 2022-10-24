import 'package:flutter/material.dart';

class WeatherCurrentDate extends StatelessWidget {
  const WeatherCurrentDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Monday',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Text('04 September'),
      ],
    );
  }
}
