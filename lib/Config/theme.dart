import 'package:flutter/material.dart';
import 'package:semanalysis/Config/color.dart';

var lightTheme = ThemeData(
  useMaterial3: true,
  // Colors
  colorScheme: const ColorScheme.light(
    primary: primary,
    surface: background,
    onSecondary: black,
    onPrimary: white,
    tertiary: label,
  ),

  // App bar theme
  appBarTheme: const AppBarTheme(
    backgroundColor: primary,
  ),

  // Textfield theme
  inputDecorationTheme: const InputDecorationTheme(
    constraints: BoxConstraints(
      maxHeight: 50,
      maxWidth: 130,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      borderSide: BorderSide(
        color: primary,
        width: 1.5,
      ),
    ),
    floatingLabelStyle: TextStyle(
      color: primary,
      fontWeight: FontWeight.w600,
    ),
    labelStyle: TextStyle(
      color: label,
      fontSize: 14,
    ),
    hintStyle: TextStyle(
      color: label,
      fontSize: 14,
    ),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        borderSide: BorderSide.none),
    filled: true,
    fillColor: white,
  ),

  // Font typography
  textTheme: TextTheme(
    headlineMedium: const TextStyle(
      fontFamily: 'Hind',
      fontWeight: FontWeight.w500,
      color: primary,
    ),
    headlineSmall: const TextStyle(
      fontFamily: 'Hind',
      fontWeight: FontWeight.w500,
      color: primary,
      fontSize: 22,
    ),
    labelLarge: const TextStyle(
      fontFamily: 'Hind',
      color: label,
      fontSize: 14,
    ),
    labelMedium: const TextStyle(
      fontFamily: 'Hind',
      color: black,
      fontSize: 14,
    ),
    labelSmall: const TextStyle(
      fontFamily: 'Hind',
      color: primary,
      fontSize: 14,
    ),
    titleLarge: const TextStyle(
      fontFamily: 'Hind',
      color: white,
      fontSize: 18,
    ),
    titleMedium: const TextStyle(
      fontFamily: 'Hind',
      color: white,
      fontSize: 16,
    ),
    titleSmall: const TextStyle(
      fontFamily: 'Hind',
      color: white,
      fontSize: 14,
      textBaseline: TextBaseline.alphabetic,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Hind',
      color: Colors.red[700],
      fontSize: 12,
    ),
  ),
);
