import 'package:flutter/material.dart';
import 'package:talk2statue/Authentication/presentation/views/login.dart';
import 'package:talk2statue/Authentication/presentation/views/sign_up.dart';
import 'package:talk2statue/home/presentation/views/home_page.dart';
import 'package:talk2statue/onboarding/view/onboarding_view.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case OnBoardingView.routeName:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case LoginPage.routeName:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case SignUpPage.routeName:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
    return null;
  }
}
