import 'package:flutter/material.dart';

class AppTheme {
  // ☀️ LIGHT THEME — Latte & Coffee Vibes
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF7F2E9), // latte cream background
    primaryColor: const Color(0xFF6B4F41), // coffee brown
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF6B4F41), // coffee brown
      foregroundColor: Colors.white,
      elevation: 2,
    ),

    cardColor: Colors.white,

    colorScheme: const ColorScheme.light(
      primary: Color(0xFF6B4F41),     // coffee
      secondary: Color(0xFFC9A66B),   // caramel
      tertiary: Color(0xFF7C9A92),    // soft green sage
    ),
  );

  // 🌙 DARK THEME — Espresso Night Mode
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF1A110E), // dark espresso brown
    primaryColor: const Color(0xFF2C1C14), // deep roast

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF2C1C14),
      foregroundColor: Colors.white,
      elevation: 0,
    ),

    cardColor: const Color(0xFF241914), // mocha brown card

    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFF2D6B3),   // cappuccino foam
      secondary: Color(0xFFE6A96B), // caramel bright
      tertiary: Color(0xFF9BB7A6),  // muted sage green
    ),
  );
}
