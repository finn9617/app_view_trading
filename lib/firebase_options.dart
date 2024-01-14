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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDyPy3jEU27UlZgevW8UtifrW9vsSY1tfw',
    appId: '1:308049859709:android:a3a2ec77dfc726bea44d14',
    messagingSenderId: '308049859709',
    projectId: 'app-clone-36dd5',
    storageBucket: 'app-clone-36dd5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBK2gvekDhmErAuQMBnAOa0-jkMdxLOzc4',
    appId: '1:308049859709:ios:9008b2f4a6d8fa5aa44d14',
    messagingSenderId: '308049859709',
    projectId: 'app-clone-36dd5',
    storageBucket: 'app-clone-36dd5.appspot.com',
    androidClientId: '308049859709-6tk1dcronrpvv8col3lmagtiagh21lak.apps.googleusercontent.com',
    iosClientId: '308049859709-ahl8docgkj1s7c0fu9nqd7rth44blu44.apps.googleusercontent.com',
    iosBundleId: 'com.example.appViewTrading',
  );
}
