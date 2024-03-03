import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk2statue/conversation/data/datasource/conversation_remote_datasource.dart';
import 'package:talk2statue/conversation/data/repository/conversation_repository.dart';
import 'package:talk2statue/conversation/domain/repository/base_conversation_repository.dart';
import 'package:talk2statue/conversation/domain/services/create_speech_from_text.dart';
import 'package:talk2statue/conversation/domain/services/transcribe_audio_to_text.dart';
import 'package:talk2statue/core/app.dart';
import 'package:talk2statue/core/app_observer.dart';
import 'package:talk2statue/statue_recognition/data/datasource/statue_recognition_remote_datasource.dart';
import 'package:talk2statue/statue_recognition/data/repository/statue_recognition_respository.dart';
import 'package:talk2statue/statue_recognition/domain/repository/base_statue_recognation_repository.dart';
import 'package:talk2statue/statue_recognition/domain/services/recognize_statue.dart';

import 'firebase_options.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = const AppBlocObserver();
  final appDio = Dio();
  BaseConversationRepository bstr = ConversationRepository(
    ConversationRemoteDataSources(appDio),
  );
  BaseStatueRecognitionRepository bsrr =
      StatueRecognitionRepository(StatueRecognitionRemoteDataSource(appDio));

  runApp(
    Talk2Statue(
      speechCreatingService: SpeechCreatingService(bstr),
      audioTranscriptionService: AudioTranscriptionService(bstr),
      statueRecognitionService: StatueRecognitionService(bsrr),
    ),
  );
}
