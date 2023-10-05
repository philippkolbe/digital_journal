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
    apiKey: 'AIzaSyDxjYRNTU19Cfz3-gxEq8DZRgWXgEZiyhw',
    appId: '1:34904889276:web:16906ac9e09ae4cfc23db9',
    messagingSenderId: '34904889276',
    projectId: 'journal-8642a',
    authDomain: 'journal-8642a.firebaseapp.com',
    storageBucket: 'journal-8642a.appspot.com',
    measurementId: 'G-KW4TWYEBSH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAsUuN_3dWHVcXQnkbblpaWBSIJAEPKaOo',
    appId: '1:34904889276:android:1c5407181f5cb9acc23db9',
    messagingSenderId: '34904889276',
    projectId: 'journal-8642a',
    storageBucket: 'journal-8642a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCbp2zW16vQDqTB0EMcncA0X2bx4P16o5E',
    appId: '1:34904889276:ios:65ee592318ac515ec23db9',
    messagingSenderId: '34904889276',
    projectId: 'journal-8642a',
    storageBucket: 'journal-8642a.appspot.com',
    iosBundleId: 'com.example.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCbp2zW16vQDqTB0EMcncA0X2bx4P16o5E',
    appId: '1:34904889276:ios:d81da4d31905f41cc23db9',
    messagingSenderId: '34904889276',
    projectId: 'journal-8642a',
    storageBucket: 'journal-8642a.appspot.com',
    iosBundleId: 'com.example.app.RunnerTests',
  );
}
