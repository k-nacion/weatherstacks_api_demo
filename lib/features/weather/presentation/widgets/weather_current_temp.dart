import 'package:flutter/material.dart';

class WeatherCurrentTemp extends StatelessWidget {
  const WeatherCurrentTemp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '45°',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 128,
                  color: Theme.of(context).textTheme.displayLarge?.color?.withOpacity(1),
                ),
          ),
          Text(
            'Sunny',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
