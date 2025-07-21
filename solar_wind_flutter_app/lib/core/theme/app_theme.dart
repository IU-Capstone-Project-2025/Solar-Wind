import 'package:flutter/material.dart';

const mainPink = Color(0xFFF34BD5); // UIColor(red: 243/255, green: 75/255, blue: 213/255, alpha: 1)
const mainYellow = Color(0xFFFBDA55); // UIColor(red: 251/255, green: 218/255, blue: 85/255, alpha: 1)

final lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFFDFDFD),
  primaryColor: mainPink,
  colorScheme: ColorScheme.light(
    primary: mainPink,
    secondary: mainYellow,
    background: const Color(0xFFFDFDFD),
    surface: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    onBackground: Colors.black,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: mainPink,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: mainYellow,
    foregroundColor: Colors.black,
  ),
  chipTheme: ChipThemeData(
    selectedColor: mainPink.withOpacity(0.2),
    backgroundColor: Colors.grey.shade200,
    disabledColor: Colors.grey.shade100,
    labelStyle: const TextStyle(color: Colors.black),
    secondaryLabelStyle: const TextStyle(color: Colors.black),
    brightness: Brightness.light,
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF121212),
  primaryColor: mainPink,
  colorScheme: ColorScheme.dark(
    primary: mainPink,
    secondary: mainYellow,
    background: const Color(0xFF121212),
    surface: const Color(0xFF1E1E1E),
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.white,
    onBackground: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1E1E1E),
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: mainYellow,
    foregroundColor: Colors.black,
  ),
  chipTheme: ChipThemeData(
    selectedColor: mainPink.withOpacity(0.2),
    backgroundColor: Colors.grey.shade800,
    disabledColor: Colors.grey.shade700,
    labelStyle: const TextStyle(color: Colors.white),
    secondaryLabelStyle: const TextStyle(color: Colors.white),
    brightness: Brightness.dark,
  ),
);
