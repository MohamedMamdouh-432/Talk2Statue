import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk2statue/core/app.dart';
import 'package:talk2statue/core/app_observer.dart';
import 'package:talk2statue/speech_transcription/data/datasource/speech_transcription_remote_datasource.dart';
import 'package:talk2statue/speech_transcription/data/repository/speech_transcription_repository.dart';
import 'package:talk2statue/speech_transcription/domain/repository/base_speech_transcription_repository.dart';
import 'package:talk2statue/speech_transcription/domain/services/create_speech_from_text.dart';
import 'package:talk2statue/speech_transcription/domain/services/transcribe_audio_to_text.dart';
import 'firebase_options.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = const AppBlocObserver();
  BaseSpeechTranscriptionRepository bstr = SpeechTranscriptionRepository(
    SpeechTranscriptionRemoteDataSources(
      Dio(),
    ),
  );

  runApp(
    Talk2Statue(
      speechCreatingService: SpeechCreatingService(bstr),
      audioTranscriptionService: AudioTranscriptionService(bstr),
    ),
  );
}
