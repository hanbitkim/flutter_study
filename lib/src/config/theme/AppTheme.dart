import 'package:flutter/material.dart';

class Apptheme {
  static ThemeData get light {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: Colors.green
      ),
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.green,
      splashColor: Colors.transparent
    );
  }
}