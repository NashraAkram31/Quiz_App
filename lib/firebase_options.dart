// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyAyErCg0OsB4jMUWOSXBSqAZwcpcMtU5bs',
    appId: '1:1055849685315:web:62c16f1e879135ef240ff6',
    messagingSenderId: '1055849685315',
    projectId: 'quizapp-92dde',
    authDomain: 'quizapp-92dde.firebaseapp.com',
    storageBucket: 'quizapp-92dde.appspot.com',
    measurementId: 'G-B7PT9DPCFX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDCX7RkAKt6YljPKgKt4oVI9fTdAzETSEg',
    appId: '1:1055849685315:android:23ce9d004180f8d4240ff6',
    messagingSenderId: '1055849685315',
    projectId: 'quizapp-92dde',
    storageBucket: 'quizapp-92dde.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD_PEODjQCHL6o6Vt8INX2sZGpZoJz2TYk',
    appId: '1:1055849685315:ios:85387e2ed7d019cb240ff6',
    messagingSenderId: '1055849685315',
    projectId: 'quizapp-92dde',
    storageBucket: 'quizapp-92dde.appspot.com',
    iosBundleId: 'com.example.quizapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD_PEODjQCHL6o6Vt8INX2sZGpZoJz2TYk',
    appId: '1:1055849685315:ios:85387e2ed7d019cb240ff6',
    messagingSenderId: '1055849685315',
    projectId: 'quizapp-92dde',
    storageBucket: 'quizapp-92dde.appspot.com',
    iosBundleId: 'com.example.quizapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAyErCg0OsB4jMUWOSXBSqAZwcpcMtU5bs',
    appId: '1:1055849685315:web:306a3dd3a4617279240ff6',
    messagingSenderId: '1055849685315',
    projectId: 'quizapp-92dde',
    authDomain: 'quizapp-92dde.firebaseapp.com',
    storageBucket: 'quizapp-92dde.appspot.com',
    measurementId: 'G-H3FCXQTSXC',
  );
}
