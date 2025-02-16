// Tema aplikasi
import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: false,
  primaryColor: const Color(0xFF776FFF),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF776FFF),
  ),
  scaffoldBackgroundColor: const Color(0xFFF9F7F7),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF776FFF),
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF776FFF),
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
  cardTheme: CardTheme(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    color: Colors.white,
  ),
);
