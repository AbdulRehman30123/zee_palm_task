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
    apiKey: 'AIzaSyALyK0j-os6xSgA-G0cGXmTihFEzzBhMYU',
    appId: '1:881029220728:web:c348ec9e20d7b83ba6a08d',
    messagingSenderId: '881029220728',
    projectId: 'fir-practice-a2908',
    authDomain: 'fir-practice-a2908.firebaseapp.com',
    databaseURL: 'https://fir-practice-a2908-default-rtdb.firebaseio.com',
    storageBucket: 'fir-practice-a2908.appspot.com',
    measurementId: 'G-KB1MB2J35M',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBbNPudmSKEF78czNPPnJzBqrGZfapu4j8',
    appId: '1:881029220728:android:78911074c797883ea6a08d',
    messagingSenderId: '881029220728',
    projectId: 'fir-practice-a2908',
    databaseURL: 'https://fir-practice-a2908-default-rtdb.firebaseio.com',
    storageBucket: 'fir-practice-a2908.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCQx9rKtEkxRwC1v5fcHmjiPBJhdSCkAcg',
    appId: '1:881029220728:ios:a8f601c4f07ebfe4a6a08d',
    messagingSenderId: '881029220728',
    projectId: 'fir-practice-a2908',
    databaseURL: 'https://fir-practice-a2908-default-rtdb.firebaseio.com',
    storageBucket: 'fir-practice-a2908.appspot.com',
    iosBundleId: 'com.example.zeePalmTask',
  );
}
