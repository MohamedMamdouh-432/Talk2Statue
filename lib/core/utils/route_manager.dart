import 'package:get/get.dart';
import 'package:talk2statue/authentication/views/sign_in.dart';
import 'package:talk2statue/authentication/views/sign_up.dart';
import 'package:talk2statue/conversation/views/converstaion_screen.dart';
import 'package:talk2statue/home/views/home_view.dart';
import 'package:talk2statue/home/views/talk_to_statue_view.dart';
import 'package:talk2statue/onboarding/view/onboarding_view.dart';

class RouteManager {
  static const String onboardingRoute = '/onboarding';
  static const String signInRoute = '/signIn';
  static const String signUpRoute = '/signUp';
  static const String homeRoute = '/home';
  static const String talkToStatueRoute = '/talkToStatue';
  static const String conversationRoute = '/conversation';

  static List<GetPage> appRoutes = [
    GetPage(
      name: onboardingRoute,
      page: () => const OnBoardingView(),
    ),
    GetPage(
      name: signInRoute,
      page: () => const SignInPage(),
    ),
    GetPage(
      name: signUpRoute,
      page: () => const SignUpPage(),
    ),
    GetPage(
      name: homeRoute,
      page: () => const HomeView(),
    ),
    GetPage(
      name: talkToStatueRoute,
      page: () => const TalkToStatueView(),
    ),
    GetPage(
      name: conversationRoute,
      page: () => const ConversationScreen(),
    ),
  ];
}
