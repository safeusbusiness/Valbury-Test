import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeConfig {

  static Color textColor = Colors.black;
  static Color primaryColor = const Color(0xffff3627);
  static Color secondaryColor = const Color(0xffff7a00);
  static Color backgroundColorLight = Colors.white;
  static Color backgroundColorDark = const Color(0xff2A2B2E);

  static ThemeData theme = ThemeData.light().copyWith(
    primaryColor: primaryColor,
    primaryColorLight: backgroundColorLight,
    primaryColorDark: backgroundColorDark,
    canvasColor: Colors.transparent,
    unselectedWidgetColor: const Color(0xffe8e8e8),
    hintColor: const Color(0xffcacccf),
    appBarTheme: const AppBarTheme(elevation: 6),
    shadowColor: const Color(0xfff6f6f6),
    textTheme: const TextTheme().copyWith(
      titleLarge: GoogleFonts.montserrat(
          textStyle: TextStyle(
        color: textColor,
        height: 1.4,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      )),
      headlineLarge: GoogleFonts.lato(
          textStyle: TextStyle(
        color: textColor,
        height: 1.4,
        fontWeight: FontWeight.bold,
        fontSize: 26,
      )),
      headlineMedium: GoogleFonts.lato(
          textStyle: TextStyle(
        color: textColor,
        height: 1.4,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      )),
      headlineSmall: GoogleFonts.lato(
          textStyle: TextStyle(
        color: textColor,
        height: 1.4,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      )),
      displaySmall: GoogleFonts.lato(
          textStyle: TextStyle(
        color: textColor,
        height: 1.4,
        fontWeight: FontWeight.w900,
        fontSize: 16,
      )),
      displayMedium: GoogleFonts.lato(
          textStyle: TextStyle(
        color: textColor,
        height: 1.4,
        fontWeight: FontWeight.w900,
        fontSize: 18,
      )),
      displayLarge: GoogleFonts.lato(
          textStyle: TextStyle(
        color: textColor,
        height: 1.4,
        fontWeight: FontWeight.w900,
        fontSize: 20,
      )),
      bodyLarge: GoogleFonts.lato(
          textStyle: TextStyle(
        height: 1.4,
        color: textColor,
        fontSize: 14,
      )),
      bodyMedium: GoogleFonts.lato(
          textStyle: TextStyle(
        height: 1.4,
        color: textColor,
        fontSize: 12,
      )),
      labelLarge: GoogleFonts.lato(
          textStyle: TextStyle(
        color: textColor,
        height: 1.4,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      )),
      labelMedium: GoogleFonts.lato(
          textStyle: TextStyle(
        color: textColor,
        height: 1.4,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      )),
      labelSmall: GoogleFonts.lato(
          textStyle: TextStyle(
        color: textColor,
        height: 1.4,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      )),
    ),
    colorScheme: ThemeData.light()
        .colorScheme
        .copyWith(secondary: textColor)
        .copyWith(background: backgroundColorLight),
  );
}
