import 'package:flutter/material.dart';

class ThemeColors {
  static const MaterialColor primary = MaterialColor(
    0xffeac6b7, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffeac6b7), //10%
      100: Color(0xffeac6b7), //20%
      200: Color(0xffeac6b7), //30%
      300: Color(0xffeac6b7), //40%
      400: Color(0xffeac6b7), //50%
      500: Color(0xffeac6b7), //60%
      600: Color(0xffeac6b7), //70%
      700: Color(0xffeac6b7), //80%
      800: Color(0xffeac6b7), //90%
      900: Color(0xffeac6b7), //100%
    },
  );

  static const MaterialColor secondary = MaterialColor(
    0xffDEA790,
    <int, Color>{
      50: Color(0xffDEA790), //10%
      100: Color(0xffDEA790), //20%
      200: Color(0xffDEA790), //30%
      300: Color(0xffDEA790), //40%
      400: Color(0xffDEA790), //50%
      500: Color(0xffDEA790), //60%
      600: Color(0xffDEA790), //70%
      700: Color(0xffDEA790), //80%
      800: Color(0xffDEA790), //90%
      900: Color(0xffDEA790), //100%
    },
  );
}
