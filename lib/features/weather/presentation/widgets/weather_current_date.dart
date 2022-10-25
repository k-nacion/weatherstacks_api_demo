import 'package:flutter/material.dart';

class WeatherCurrentDate extends StatelessWidget {
  const WeatherCurrentDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Monday',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text('04 September', style: Theme.of(context).textTheme.headlineSmall),
        ],
      ),
    );
  }
}
