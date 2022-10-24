import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WeatherAppBar extends StatelessWidget {
  const WeatherAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: FaIcon(FontAwesomeIcons.bars),
          ),
          Text(
            'TAGUIG',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.magnifyingGlass))
        ],
      ),
    );
  }
}
