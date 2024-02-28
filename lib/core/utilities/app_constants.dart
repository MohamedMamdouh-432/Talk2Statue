import 'package:flutter/material.dart';

class AppConstants {
  static Color primaryColor = const Color.fromARGB(255, 200, 138, 94);
  static double screenPadding = 10;
  static Color goldColor = const Color(0xffFFD700);
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
