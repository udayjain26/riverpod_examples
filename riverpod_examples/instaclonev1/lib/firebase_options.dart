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
    apiKey: 'AIzaSyCAVaPXJa3DnrIg-2UB2aVA2oJceZ3PuVc',
    appId: '1:733034944341:web:547b7c7c8ae9aa32aac1dc',
    messagingSenderId: '733034944341',
    projectId: 'v1-instaclone-backend',
    authDomain: 'v1-instaclone-backend.firebaseapp.com',
    storageBucket: 'v1-instaclone-backend.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAjvI1aoUpYqeabYvhRSoKNweqfAlVN7pQ',
    appId: '1:733034944341:android:6e1a1c74da7aa291aac1dc',
    messagingSenderId: '733034944341',
    projectId: 'v1-instaclone-backend',
    storageBucket: 'v1-instaclone-backend.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD48072PEFMbeW-LjDPdaRLU3oHh-WOmrI',
    appId: '1:733034944341:ios:8f4afa619b113a0baac1dc',
    messagingSenderId: '733034944341',
    projectId: 'v1-instaclone-backend',
    storageBucket: 'v1-instaclone-backend.appspot.com',
    iosBundleId: 'me.udayjain.instaclonev1',
  );
}
