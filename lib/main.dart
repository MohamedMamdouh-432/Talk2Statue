import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_repository/data_repository.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talk2statue/core/app.dart';
import 'package:talk2statue/core/app_observer.dart';
import 'package:talk2statue/firebase_options.dart';
import 'package:user_repository/user_repository.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final Dio appDio = Dio();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseStore = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn.standard();
  final SharedPreferences sharedPref = await SharedPreferences.getInstance();

  Bloc.observer = const AppBlocObserver();
  sharedPref.getBool('newToApp?') ?? sharedPref.setBool('newToApp?', true);

  runApp(
    Talk2Statue(
      sharedPref: sharedPref,
      dataRepo: DataRepository(dio: appDio),
      userRepo: UserRepository(sharedPreferences: sharedPref),
      authRepo: AuthenticationRepository(
        firebaseAuth: firebaseAuth,
        googleSignIn: googleSignIn,
        firestore: firebaseStore,
        sharedPreferences: sharedPref,
      ),
    ),
  );
}
