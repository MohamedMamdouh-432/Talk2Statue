import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talk2statue/Authentication/bloc/login_cubit.dart';
import 'package:talk2statue/conversation/domain/services/create_speech_from_text.dart';
import 'package:talk2statue/conversation/domain/services/replay_visitor_question.dart';
import 'package:talk2statue/conversation/domain/services/transcribe_audio_to_text.dart';
import 'package:talk2statue/conversation/presentation/bloc/conversation_bloc.dart';
import 'package:talk2statue/core/route_generator.dart';
import 'package:talk2statue/core/utilities/app_constants.dart';
import 'package:talk2statue/onboarding/bloc/onboarding_bloc.dart';
import 'package:talk2statue/onboarding/view/onboarding_view.dart';
import 'package:talk2statue/statue_recognition/domain/services/recognize_statue.dart';
import 'package:talk2statue/statue_recognition/presentation/bloc/statue_recognition_bloc.dart';

class Talk2Statue extends StatelessWidget {
  final SpeechCreatingService speechCreatingService;
  final StatueRecognitionService statueRecognitionService;
  final AudioTranscriptionService audioTranscriptionService;
  final GPTReplayingVisitorQuestionService gptReplayingVisitorQuestionService;

  const Talk2Statue({
    super.key,
    required this.speechCreatingService,
    required this.audioTranscriptionService,
    required this.statueRecognitionService,
    required this.gptReplayingVisitorQuestionService,
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
                gptReplayingVisitorQuestionService:
                    gptReplayingVisitorQuestionService,
              ),
            ),
            BlocProvider(
              create: (context) => StatueRecognitionBloc(
                statueRecognitionService: statueRecognitionService,
              ),
            ),
            BlocProvider(create: (context) => LoginCubit()),
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
      initialRoute: OnBoardingView.routeName,
    );
  }
}
