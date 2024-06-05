import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpWithEmailAndPasswordFailure implements Exception {
  final String message;

  const SignUpWithEmailAndPasswordFailure([this.message = '']);

  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}

class LogInWithEmailAndPasswordFailure implements Exception {
  final String message;

  const LogInWithEmailAndPasswordFailure([this.message = '']);

  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          'Incorrect password, please try again.',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }
}

class LogInWithGoogleFailure implements Exception {
  final String message;

  const LogInWithGoogleFailure([this.message = '']);

  factory LogInWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const LogInWithGoogleFailure(
          'Account exists with different credentials.',
        );
      case 'invalid-credential':
        return const LogInWithGoogleFailure(
          'The credential received is malformed or has expired.',
        );
      case 'operation-not-allowed':
        return const LogInWithGoogleFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'user-disabled':
        return const LogInWithGoogleFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithGoogleFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithGoogleFailure(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const LogInWithGoogleFailure(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const LogInWithGoogleFailure(
          'The credential verification ID received is invalid.',
        );
      default:
        return const LogInWithGoogleFailure();
    }
  }
}

class LogOutFailure implements Exception {}

class AuthenticationFailure {
  final String message;
  AuthenticationFailure({this.message = ''});
}

class AuthenticationRepository {
  final FirebaseAuth _fireAuth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;
  final SharedPreferences _sharedPreference;
  String? _userId;

  AuthenticationRepository({
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
    required FirebaseFirestore firestore,
    required SharedPreferences sharedPreferences,
  })  : _fireAuth = firebaseAuth,
        _firestore = firestore,
        _googleSignIn = googleSignIn,
        _sharedPreference = sharedPreferences;

  bool get userExists => _userId != null;

  Future<String?> get userId async {
    _userId = _sharedPreference.getString('userId');
    if (_userId == null || _userId == '' || _userId!.isEmpty) return null;
    return _userId;
  }

  Future<Either<SignUpWithEmailAndPasswordFailure, void>>
      signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential userCredentials =
          await _fireAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _firestore.collection('users').doc(userCredentials.user!.uid).set({
        'name': name,
        'email': email,
      });
      await _sharedPreference.setString('userId', userCredentials.user!.uid);
      await _sharedPreference.setBool('first_time', false);

      return Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(SignUpWithEmailAndPasswordFailure.fromCode(e.code));
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  Future<void> logInWithGoogle() async {
    try {
      late final AuthCredential credential;
      if (kIsWeb) {
        final googleProvider = GoogleAuthProvider();
        final userCredential = await _fireAuth.signInWithPopup(
          googleProvider,
        );
        credential = userCredential.credential!;
      } else {
        final googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;
        credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
      }

      await _fireAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw LogInWithGoogleFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithGoogleFailure();
    }
  }

  Future<Either<AuthenticationFailure, String>> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredentials =
          await _fireAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _userId = userCredentials.user!.uid;

      await _sharedPreference.setString('userId', _userId!);
      await _sharedPreference.setBool('first_time', false);

      return Right(_userId!);
    } on LogInWithEmailAndPasswordFailure catch (e) {
      return Left(AuthenticationFailure(message: e.message));
    } on FirebaseAuthException catch (e) {
      return Left(AuthenticationFailure(
          message: LogInWithEmailAndPasswordFailure.fromCode(e.code).message));
    } catch (_) {
      return Left(AuthenticationFailure());
    }
  }

  Future<void> logOut() async {
    try {
      _userId = null;

      await _sharedPreference.remove('userId');
      await Future.wait([
        _fireAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }
}
