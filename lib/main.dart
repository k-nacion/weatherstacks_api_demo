import 'package:flutter/material.dart';
import 'package:weatherstacks_api_demo/core/route/router.dart';
import 'package:weatherstacks_api_demo/core/theme/theme.dart';
import 'package:weatherstacks_api_demo/features/weather/weather_di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await weatherDiInit();
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      routerConfig: router,
    );
  }
}
