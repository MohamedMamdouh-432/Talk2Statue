import 'package:flutter/material.dart';
import 'package:talk2statue/onboarding/view/onboarding_view.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case OnBoardingView.routeName:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
    }
    return null;
  }
}
