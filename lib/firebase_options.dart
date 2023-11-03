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
    apiKey: 'AIzaSyBb4oBD3ErJIY_JbvSzmgKvZ1NL3v-hu5s',
    appId: '1:740038564434:android:4d7f58996b744b93645d8b',
    messagingSenderId: '740038564434',
    projectId: 'doni-pizza',
    storageBucket: 'doni-pizza.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA8WCCDuTDAd-_IAx5-4D034jkfh3kvg6M',
    appId: '1:740038564434:ios:98580dfa6b444a13645d8b',
    messagingSenderId: '740038564434',
    projectId: 'doni-pizza',
    storageBucket: 'doni-pizza.appspot.com',
    androidClientId: '740038564434-84n8rah79qkes809p5q88si8chbj1vn7.apps.googleusercontent.com',
    iosClientId: '740038564434-m8hpb0d0ifkkpl3gch3oc1vs88e8jgvd.apps.googleusercontent.com',
    iosBundleId: 'com.example.pizza',
  );
}
