import 'package:data_repository/data_repository.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk2statue/core/app.dart';
import 'package:talk2statue/core/app_observer.dart';

import 'firebase_options.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = const AppBlocObserver();
  final appDio = Dio();

  runApp(
    Talk2Statue(
      appDio: appDio,
      dataRepository: DataRepository(dio: appDio),
    ),
  );
}
