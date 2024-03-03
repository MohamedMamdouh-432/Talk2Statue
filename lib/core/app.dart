import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talk2statue/Authentication/bloc/login_cubit.dart';
import 'package:talk2statue/conversation/presentation/bloc/conversation_bloc.dart';
import 'package:talk2statue/core/route_generator.dart';
import 'package:talk2statue/core/utilities/app_constants.dart';
import 'package:talk2statue/home/bloc/home_cubit.dart';
import 'package:talk2statue/home/presentation/views/home_view.dart';
import 'package:talk2statue/onboarding/bloc/onboarding_bloc.dart';
import 'package:talk2statue/conversation/domain/services/create_speech_from_text.dart';
import 'package:talk2statue/conversation/domain/services/transcribe_audio_to_text.dart';
import 'package:talk2statue/statue_recognition/bloc/statue_recognition_bloc.dart';
import 'package:talk2statue/statue_recognition/domain/services/recognize_statue.dart';

class Talk2Statue extends StatelessWidget {
  final AudioTranscriptionService audioTranscriptionService;
  final SpeechCreatingService speechCreatingService;
  final StatueRecognitionService statueRecognitionService;

  const Talk2Statue({
    super.key,
    required this.speechCreatingService,
    required this.audioTranscriptionService,
    required this.statueRecognitionService,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(320, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => OnboardingBloc()),
            BlocProvider(
              create: (context) => ConversationBloc(
                audioTranscriptionService: audioTranscriptionService,
                speechCreateService: speechCreatingService,
              ),
            ),
            BlocProvider(
              create: (context) => StatueRecognitionBloc(
                statueRecognitionService: statueRecognitionService,
              ),
            ),
            BlocProvider(create: (context) => LoginCubit()),
            BlocProvider(create: (context) => HomeCubit())
          ],
          child: const AppView(),
        );
      },
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppConstants.theme,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: HomeView.routeName,
    );
  }
}
