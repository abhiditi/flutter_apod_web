import 'package:flutter/material.dart';
import 'package:flutter_apod_web/notifier/astro_notifier.dart';
import 'package:flutter_apod_web/notifier/theme_notifier.dart';
import 'package:flutter_apod_web/screens/home_screen.dart';
import 'package:provider/provider.dart';

/* MultiProvider */
Future<void> main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ThemesNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => AstrologyNotifier(),
      ),
    ],
    child: MyApp(),
  ));
}

Future<String> _calculation = Future<String>.delayed(
  Duration(seconds: 1),
  () => 'Data Loaded',
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Astrology',
      theme: Provider.of<ThemesNotifier>(context).currentThemeData,
      home: FutureBuilder<String>(
          future: _calculation,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return HomeScreen();
            } else {
              return Container(
                  child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.lightBlueAccent,
                  color: Theme.of(context).indicatorColor,
                ),
              ));
            }
          }),
    );
  }
}
