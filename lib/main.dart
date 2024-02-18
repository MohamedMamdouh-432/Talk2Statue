import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:talk2statue/core/app.dart';
import 'package:talk2statue/core/talk2statue_observer.dart';
import 'package:talk2statue/speech_transcription/data/datasource/speech_transcription_remote_datasource.dart';
import 'package:talk2statue/speech_transcription/data/repository/speech_transcription_repository.dart';
import 'package:talk2statue/speech_transcription/domain/repository/base_speech_transcription_repository.dart';
import 'package:talk2statue/speech_transcription/domain/services/create_speech_from_text.dart';
import 'package:talk2statue/speech_transcription/domain/services/transcribe_audio_to_text.dart';

void main(List<String> args) {
  Bloc.observer = const Talk2StatueBlocObserver();
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
