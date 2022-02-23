import 'package:artitecture/src/core/utils/constants.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: Colors.green
      ),
      scaffoldBackgroundColor: Colors.white,
      primaryColor: kPrimaryColor,
      secondaryHeaderColor: kSecondaryColor,
      splashColor: Colors.transparent,
      visualDensity: VisualDensity.adaptivePlatformDensity
    );
  }
}