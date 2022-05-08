import 'package:flutter/material.dart';

class CustomColor {
  static const Color primary = Color(0xFF0C3469);
  static const Color secondary = Color(0xFFFFAF5A);
  static const Color black = Color(0xFF141414);
  static const Color grey = Color(0xFF757575);
  static const Color lightGrey = Color(0xFFE5E5E5);
  static const Color white = Color(0xFFF5F7F9);
  static const Color success = Color(0xFF34CA74);
  static const Color error = Color(0xFFFF6905);
}

ThemeData customTheme() {
  return ThemeData(
    colorSchemeSeed: CustomColor.primary,
    scaffoldBackgroundColor: CustomColor.white,
    fontFamily: 'Poppins',
    appBarTheme: AppBarTheme(
      color: CustomColor.primary,
      titleTextStyle: TextStyle(
        color: CustomColor.white,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      headline2: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      headline3: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      headline4: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      headline5: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodyText1: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      bodyText2: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
      ),
      button: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
