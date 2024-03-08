import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppConstants {
  static const Color primaryColor = Color(0xffF6D779);
  static const double screenPadding = 10;
  static const Color goldColor = Color(0xffFFD700);
  static const Color erroColor = Color.fromARGB(255, 255, 60, 0);
  static const Color onBoardingColor = Color.fromARGB(255, 222, 205, 159);
  static const Color kohlyColor = Color.fromARGB(255, 56, 107, 133);
  static GlobalKey<FormState> formState = GlobalKey<FormState>();
  static TextStyle normalStyle = TextStyle(
    fontSize: 14.sp,
    color: const Color.fromARGB(255, 56, 107, 133),
  );
  static TextStyle boldStyle = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    color: const Color.fromARGB(255, 56, 107, 133),
  );
  static ThemeData theme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: primaryColor,
  );
}
