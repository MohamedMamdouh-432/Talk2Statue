import 'package:flutter/material.dart';

class AppConstants {
  static Color primaryColor = Color(0xffF3E9E2);
  
  static ThemeData theme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: primaryColor,
    // scaffoldBackgroundColor: Colors.transparent,
    // appBarTheme: const AppBarTheme(
    //   surfaceTintColor: Colors.white,
    //   backgroundColor: Colors.transparent,
    //   shadowColor: Color.fromARGB(0, 15, 9, 9),
    //   foregroundColor: Colors.black,
    // ),
  );
}