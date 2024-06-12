import 'package:authentication_repository/authentication_repository.dart';
import 'package:data_repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talk2statue/authentication/cubit/login_cubit.dart';
import 'package:talk2statue/conversation/bloc/conversation_bloc.dart';
import 'package:talk2statue/core/utils/app_constants.dart';
import 'package:talk2statue/core/utils/route_manager.dart';
import 'package:talk2statue/home/bloc/recognition_bloc.dart';
import 'package:talk2statue/onboarding/bloc/onboarding_bloc.dart';
import 'package:user_repository/user_repository.dart';

class Talk2Statue extends StatelessWidget {
  final DataRepository dataRepo;
  final UserRepository userRepo;
  final SharedPreferences sharedPref;
  final AuthenticationRepository authRepo;

  const Talk2Statue({
    super.key,
    required this.dataRepo,
    required this.authRepo,
    required this.userRepo,
    required this.sharedPref,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(320, 690),
      builder: (context, child) {
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider.value(value: dataRepo),
            RepositoryProvider.value(value: authRepo),
            RepositoryProvider.value(value: userRepo),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => OnboardingBloc()),
              BlocProvider(create: (_) => LoginCubit()),
              BlocProvider(create: (_) => RecognitionBloc(dataRepo: dataRepo)),
              BlocProvider(create: (_) => ConversationBloc(dataRepo: dataRepo)),
            ],
            child: AppView(sharedPref: sharedPref),
          ),
        );
      },
    );
  }
}

class AppView extends StatelessWidget {
  final SharedPreferences sharedPref;
  const AppView({
    super.key,
    required this.sharedPref,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppConstants.primaryColor.withOpacity(0.8),
        systemNavigationBarColor: AppConstants.primaryColor.withOpacity(0.6),
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    return GetMaterialApp(
      theme: AppConstants.theme,
      debugShowCheckedModeBanner: false,
      getPages: RouteManager.appRoutes,
      initialRoute: sharedPref.getBool('newToApp?')!
          ? RouteManager.onboardingRoute
          : RouteManager.signInRoute,
    );
  }
}
