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
        return ios;
      case TargetPlatform.macOS:
        return macos;
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
    apiKey: 'AIzaSyBHlgsMQ3ttnwQ73xVsWY5PaMWgRWKKDHE',
    appId: '1:440584015509:web:4014063aee8429debf959c',
    messagingSenderId: '440584015509',
    projectId: 'ex3-mobileapp',
    authDomain: 'ex3-mobileapp.firebaseapp.com',
    storageBucket: 'ex3-mobileapp.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAaieMztNkGDMzSnGHG_MdzwcdcPmGLHsg',
    appId: '1:440584015509:android:05dc49d62ccfe4ddbf959c',
    messagingSenderId: '440584015509',
    projectId: 'ex3-mobileapp',
    storageBucket: 'ex3-mobileapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB45R7qur_C1s68-hHg9PHepQNQbZeE8uY',
    appId: '1:440584015509:ios:945332b7341a4f33bf959c',
    messagingSenderId: '440584015509',
    projectId: 'ex3-mobileapp',
    storageBucket: 'ex3-mobileapp.appspot.com',
    iosBundleId: 'com.example.ex3',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB45R7qur_C1s68-hHg9PHepQNQbZeE8uY',
    appId: '1:440584015509:ios:321c2e51c21cac60bf959c',
    messagingSenderId: '440584015509',
    projectId: 'ex3-mobileapp',
    storageBucket: 'ex3-mobileapp.appspot.com',
    iosBundleId: 'com.example.ex3.RunnerTests',
  );
}