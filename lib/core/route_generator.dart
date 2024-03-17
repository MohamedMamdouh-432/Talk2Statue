import 'package:flutter/material.dart';
import 'package:talk2statue/Authentication/presentation/views/sign_in.dart';
import 'package:talk2statue/Authentication/presentation/views/sign_up.dart';
import 'package:talk2statue/conversation/presentation/views/conversation_view.dart';
import 'package:talk2statue/home/presentation/views/home_view.dart';
import 'package:talk2statue/onboarding/view/onboarding_view.dart';
import 'package:talk2statue/statue_recognition/presentation/views/talk_to_statue_view.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case OnBoardingView.routeName:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case SignInPage.routeName:
        return MaterialPageRoute(builder: (_) => const SignInPage());
      case SignUpPage.routeName:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case HomeView.routeName:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case TalkToStatueView.routeName:
        return MaterialPageRoute(builder: (_) => const TalkToStatueView());
      case ConversationView.routeName:
        return MaterialPageRoute(builder: (_) => const ConversationView());
    }
    return null;
  }
}
