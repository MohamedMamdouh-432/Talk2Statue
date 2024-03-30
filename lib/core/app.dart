import 'package:data_repository/data_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talk2statue/Authentication/bloc/login_cubit.dart';
import 'package:talk2statue/conversation/bloc/conversation_bloc.dart';
import 'package:talk2statue/core/route_generator.dart';
import 'package:talk2statue/core/utils/app_constants.dart';
import 'package:talk2statue/onboarding/bloc/onboarding_bloc.dart';
import 'package:talk2statue/onboarding/view/onboarding_view.dart';
import 'package:talk2statue/statue_recognition/bloc/statue_recognition_bloc.dart';

class Talk2Statue extends StatelessWidget {
  final Dio appDio;
  final DataRepository dataRepository;

  const Talk2Statue({
    super.key,
    required this.appDio,
    required this.dataRepository,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(320, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return RepositoryProvider(
          create: (context) => DataRepository(dio: appDio),
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => OnboardingBloc()),
              BlocProvider(
                create: (context) => ConversationBloc(
                  dataRepository: dataRepository,
                ),
              ),
              BlocProvider(
                create: (context) => StatueRecognitionBloc(
                  dataRepository: dataRepository,
                ),
              ),
              BlocProvider(create: (context) => LoginCubit()),
            ],
            child: const AppView(),
          ),
        );
      },
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

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
    return MaterialApp(
      theme: AppConstants.theme,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: OnBoardingView.routeName,
    );
  }
}
