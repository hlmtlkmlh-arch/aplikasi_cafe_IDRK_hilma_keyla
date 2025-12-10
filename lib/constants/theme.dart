import 'package:flutter/material.dart';
import 'colors.dart';


final ThemeData lightTheme = ThemeData(
brightness: Brightness.light,
primaryColor: cafeGreen,
scaffoldBackgroundColor: Colors.white,
fontFamily: 'Poppins',
appBarTheme: const AppBarTheme(
backgroundColor: Colors.transparent,
elevation: 0,
foregroundColor: Colors.black,
),
);


final ThemeData darkTheme = ThemeData(
brightness: Brightness.dark,
primaryColor: cafeGreen,
scaffoldBackgroundColor: const Color(0xFF0B0F12),
fontFamily: 'Poppins',
);