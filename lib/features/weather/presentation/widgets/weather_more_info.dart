import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WeatherMoreInfo extends StatelessWidget {
  const WeatherMoreInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 45),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              TemperatureUp(),
              Precipitation(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              TemperatureDown(),
              WindSpeed(),
            ],
          ),
        ],
      ),
    );
  }
}

class WindSpeed extends StatelessWidget {
  const WindSpeed({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const FaIcon(FontAwesomeIcons.temperatureArrowDown),
        const SizedBox(width: 16),
        Text(
          '21°',
          style: Theme.of(context).textTheme.headlineSmall,
        )
      ],
    );
  }
}

class TemperatureUp extends StatelessWidget {
  const TemperatureUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const FaIcon(FontAwesomeIcons.temperatureArrowUp),
        const SizedBox(width: 16),
        Text(
          '21°',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}

class TemperatureDown extends StatelessWidget {
  const TemperatureDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const FaIcon(FontAwesomeIcons.temperatureArrowDown),
        const SizedBox(width: 16),
        Text(
          '21°',
          style: Theme.of(context).textTheme.headlineSmall,
        )
      ],
    );
  }
}

class Precipitation extends StatelessWidget {
  const Precipitation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const FaIcon(FontAwesomeIcons.temperatureArrowUp),
        const SizedBox(width: 16),
        Text(
          'Precipitation',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
