import 'package:flutter/material.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    primarySwatch: Colors.purple,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.purple,
      foregroundColor: Colors.white,
    ),
    textTheme: TextTheme(
      titleMedium: TextStyle(color: Colors.black), // replaces bodyText1
      bodyMedium: TextStyle(color: Colors.black87), // replaces bodyText2
      headlineMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.purple), // new for headline6
    ),
  );

  static final darkTheme = ThemeData(
    primarySwatch: Colors.purple,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.purple[800],
      foregroundColor: Colors.white,
    ),
    textTheme: TextTheme(
      titleMedium: TextStyle(color: Colors.white), // replaces bodyText1
      bodyMedium: TextStyle(color: Colors.white70), // replaces bodyText2
      headlineMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.purple[300]), // new for headline6
    ),
  );
}
