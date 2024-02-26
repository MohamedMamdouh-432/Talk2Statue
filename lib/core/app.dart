import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk2statue/Authentication/bloc/login_cubit.dart';
import 'package:talk2statue/core/route_generator.dart';
import 'package:talk2statue/core/utilities/app_constants.dart';
import 'package:talk2statue/onboarding/bloc/onboarding_bloc.dart';
import 'package:talk2statue/onboarding/view/onboarding_view.dart';
import 'package:talk2statue/speech_transcription/domain/services/create_speech_from_text.dart';
import 'package:talk2statue/speech_transcription/domain/services/transcribe_audio_to_text.dart';
import 'package:talk2statue/speech_transcription/presentation/controllers/speech_transcription_bloc/speech_transcription_bloc.dart';
import 'package:talk2statue/statue_recognition/domain/services/recognize_statue.dart';
import 'package:talk2statue/statue_recognition/presentation/controllers/bloc/statue_recognition_bloc.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OnboardingBloc()),
        BlocProvider(
          create: (context) => SpeechTranscriptionBloc(
            audioTranscriptionService: audioTranscriptionService,
            speechCreateService: speechCreatingService,
          ),
        ),
        BlocProvider(
          create: (context) => StatueRecognitionBloc(
            statueRecognitionService: statueRecognitionService,
          ),
        ),
        BlocProvider(create: (context)=>LoginCubit())
      ],
      child: const AppView(),
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
