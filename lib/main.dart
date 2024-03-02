import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'theams/theme.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool _isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Care APP',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home:SplashScreen(),
    );
  }
}
