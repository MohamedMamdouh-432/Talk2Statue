// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBHFDMRHFQyJurW8CIUWXiCcrVsDgdV7Ic',
    appId: '1:416413437512:web:6f66e4673c74ef4ece127d',
    messagingSenderId: '416413437512',
    projectId: 'talk2statue-ed0cf',
    authDomain: 'talk2statue-ed0cf.firebaseapp.com',
    storageBucket: 'talk2statue-ed0cf.appspot.com',
    measurementId: 'G-SP28ZFY0F1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAvffgl9brRLwB6CIivkdpCBBph4MuUMmo',
    appId: '1:416413437512:android:c628c71dbe7b6ffdce127d',
    messagingSenderId: '416413437512',
    projectId: 'talk2statue-ed0cf',
    storageBucket: 'talk2statue-ed0cf.appspot.com',
  );
}
