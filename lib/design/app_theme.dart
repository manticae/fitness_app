import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './theme_colors.dart';

class AppTheme {
  final _primaryColor = ThemeColors.primary;
  final _secondaryColor = ThemeColors.secondary;
  final _primaryFont = GoogleFonts.merriweatherSans();
  // final _primaryFont = GoogleFonts.rubikBeastly();

  // final _secondaryFont = GoogleFonts.merriweatherSans(
  //   color: ThemeColors.secondary,
  // );

  ThemeData get appTheme {
    return ThemeData(
      primarySwatch: _primaryColor,
      primaryColor: _primaryColor,
      textTheme: TextTheme(
        headline1: _primaryFont,
        headline4: _primaryFont,
        headline6: _primaryFont,
        headline5: _primaryFont,
        bodyText1: _primaryFont,
        bodyText2: _primaryFont,
        subtitle1: _primaryFont,
      ),
      listTileTheme: ListTileThemeData(
        textColor: Colors.white,
        tileColor: _secondaryColor,
        iconColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusColor: _primaryColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: _primaryColor,
          ),
        ),
        labelStyle: _primaryFont,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: _primaryFont,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: _primaryFont,
        ),
      ),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.white,
      ),
    );
  }
}
