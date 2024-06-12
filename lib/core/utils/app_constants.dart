import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppConstants {
  static const Color primaryColor = Color.fromARGB(255, 246, 216, 128);
  static const double screenPadding = 10;
  static const Color goldColor = Color(0xffFFD700);
  static const Color erroColor = Color.fromARGB(255, 255, 60, 0);
  static const Color onBoardingColor = Color(0xffF6D880);
  static const Color kohlyColor = Color.fromARGB(255, 56, 107, 133);
  static const Color drawerColor = Color.fromARGB(255, 177, 146, 54);
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
  static List statueImages = [
    'assets/images/Circle1.jpg',
    'assets/images/Circle2.jpg',
    'assets/images/Circle3.jpg',
    'assets/images/Circle4.jpg',
  ];
}
