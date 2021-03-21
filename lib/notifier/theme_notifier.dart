import 'package:flutter/material.dart';

enum MyThemes { light, dark }

class ThemesNotifier with ChangeNotifier {
  static final List<ThemeData> themeData = [
    ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue[100],
      appBarTheme: AppBarTheme(color: Colors.blue),
      accentColor: Colors.amberAccent,
      indicatorColor: Colors.blueAccent,
      buttonColor: Colors.black,
      textTheme: TextTheme(
        headline1: TextStyle(
            fontSize: 72.0,
            fontFamily: 'Merienda',
            fontWeight: FontWeight.bold,
            color: Colors.black),
        headline6: TextStyle(
            fontSize: 36.0,
            fontFamily: 'Merienda',
            fontStyle: FontStyle.italic,
            color: Colors.black),
        bodyText1: TextStyle(
            fontSize: 18.0, fontFamily: 'Merienda', color: Colors.black),
        bodyText2: TextStyle(
            fontSize: 14.0, fontFamily: 'Merienda', color: Colors.black),
      ),
    ),
    ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.blueGrey[900],
      appBarTheme: AppBarTheme(color: Colors.deepPurple),
      indicatorColor: Colors.blueAccent,
      buttonColor: Colors.white,
      accentColor: Colors.amber,
      textTheme: TextTheme(
        headline1: TextStyle(
            fontSize: 72.0,
            fontFamily: 'Merienda',
            fontWeight: FontWeight.bold,
            color: Colors.white),
        headline6: TextStyle(
            fontSize: 36.0,
            fontFamily: 'Merienda',
            fontStyle: FontStyle.italic,
            color: Colors.white),
        bodyText1: TextStyle(
            fontSize: 18.0, fontFamily: 'Merienda', color: Colors.white),
        bodyText2: TextStyle(
            fontSize: 14.0, fontFamily: 'Merienda', color: Colors.white),
      ),
    )
  ];
  MyThemes _currentTheme = MyThemes.light;
  ThemeData _currentThemeData = themeData[0];
  void switchTheme() => currentTheme == MyThemes.light
      ? currentTheme = MyThemes.dark
      : currentTheme = MyThemes.light;

  set currentTheme(MyThemes theme) {
    if (theme != null) {
      _currentTheme = theme;
      _currentThemeData =
          currentTheme == MyThemes.light ? themeData[0] : themeData[1];

      //Notifies the theme change to app
      notifyListeners();
    }
  }

  get currentTheme => _currentTheme;
  get currentThemeData => _currentThemeData;
}
