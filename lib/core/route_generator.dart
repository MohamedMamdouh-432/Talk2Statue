import 'package:flutter/material.dart';
import 'package:talk2statue/Authentication/presentation/views/sign_in.dart';
import 'package:talk2statue/Authentication/presentation/views/sign_up.dart';
import 'package:talk2statue/home/presentation/views/home_page.dart';
import 'package:talk2statue/home/presentation/views/statue_talker.dart';
import 'package:talk2statue/onboarding/view/onboarding_view.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case OnBoardingView.routeName:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case SignInPage.routeName:
        return MaterialPageRoute(builder: (_) => const SignInPage());
      case SignUpPage.routeName:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case StatueTalker.routeName:
         return MaterialPageRoute(builder: (_)=>const StatueTalker());
    }
    return null;
  }
}
