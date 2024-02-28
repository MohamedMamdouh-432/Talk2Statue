import 'package:flutter/material.dart';
import 'package:talk2statue/Authentication/presentation/views/sign_in.dart';
import 'package:talk2statue/Authentication/presentation/views/sign_up.dart';
import 'package:talk2statue/onboarding/view/onboarding_view.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case OnBoardingView.routeName:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case SignInPage.routeName:
          return MaterialPageRoute(builder: (_)=>const SignInPage());
      case SignUpPage.routeName:
          return MaterialPageRoute(builder: (_)=>const SignUpPage());
    }
    return null;
  }
}
