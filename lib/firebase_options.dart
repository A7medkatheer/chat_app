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
    apiKey: 'AIzaSyDHjm3zv5Gk2Zp0xNFjV1rjmxmQ6Pu7SMI',
    appId: '1:903528670810:web:5f07dd269d91b7a8e5da63',
    messagingSenderId: '903528670810',
    projectId: 'chat-app-4dcbf',
    authDomain: 'chat-app-4dcbf.firebaseapp.com',
    storageBucket: 'chat-app-4dcbf.appspot.com',
    measurementId: 'G-BRFPGTB2KG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB5065APTU1YvCT0uzRI9E2WMtYkDD7pNw',
    appId: '1:903528670810:android:ac1c2aab5741dfe3e5da63',
    messagingSenderId: '903528670810',
    projectId: 'chat-app-4dcbf',
    storageBucket: 'chat-app-4dcbf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB27XVXPsqvrEBGI_U1V0EiJiJzIwvNpWc',
    appId: '1:903528670810:ios:f090e167bb20d5dae5da63',
    messagingSenderId: '903528670810',
    projectId: 'chat-app-4dcbf',
    storageBucket: 'chat-app-4dcbf.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );
}
