import 'package:flutter/material.dart';

class AppConstants {
  static const Color primaryColor = Color(0xffF6D779);
  static const double screenPadding = 10;
  static const Color goldColor = Color(0xffFFD700);
  static const Color erroColor = Color.fromARGB(255, 255, 60, 0);
  static const Color onBoardingColor = Color.fromARGB(255, 243, 231, 199);
  static GlobalKey<FormState> formState = GlobalKey<FormState>();
  static ThemeData theme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: const Color(0xffF6D779),
  );
}
