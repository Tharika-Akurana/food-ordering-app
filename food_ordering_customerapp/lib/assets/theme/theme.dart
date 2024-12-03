import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color.fromARGB(255, 2, 0, 0),
        onPrimary: Color.fromARGB(255, 3, 255, 99),
        secondary: Color.fromARGB(255, 251, 190, 190),
        onSecondary: Colors.black,
        error: Colors.red,
        onError: Colors.red,
        surface: Color.fromARGB(255, 255, 255, 255),
        onSurface: Color.fromARGB(255, 0, 0, 0)));

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
      surface: Colors.grey.shade900,
      primary: const Color.fromARGB(255, 255, 255, 255),
      //primary: const Color.fromARGB(255, 251, 148, 4),
      onPrimary: const Color.fromARGB(255, 68, 226, 76),
      secondary: const Color.fromARGB(255, 234, 83, 83)),
      
      



);
