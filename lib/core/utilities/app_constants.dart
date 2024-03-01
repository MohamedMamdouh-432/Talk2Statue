import 'package:flutter/material.dart';

class AppConstants {
  static const Color primaryColor = Color(0xffF6D779);
  static const double screenPadding = 10;
  static const Color goldColor = Color(0xffFFD700);
  static const Color onBoardingScaffoldColor =
      Color.fromARGB(255, 243, 231, 199);
  static GlobalKey<FormState> formState = GlobalKey<FormState>();
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
