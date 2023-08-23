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
    apiKey: 'AIzaSyDZVfW0IpSLnPMCmM9FtfhFCkmmftCZr2Y',
    appId: '1:218597899046:web:3f61c8989bc0e37b085fe7',
    messagingSenderId: '218597899046',
    projectId: 'account-database-f8f8a',
    authDomain: 'account-database-f8f8a.firebaseapp.com',
    storageBucket: 'account-database-f8f8a.appspot.com',
    measurementId: 'G-ERJJELJZEZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCFPRE6Ao-jkQdFwuB4EkUmIa2A2DI-yVs',
    appId: '1:218597899046:android:b7996c9489d7b098085fe7',
    messagingSenderId: '218597899046',
    projectId: 'account-database-f8f8a',
    storageBucket: 'account-database-f8f8a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCpDeSY5Vo8XwYMIGhnGT0e1le6IsPe3u0',
    appId: '1:218597899046:ios:ae71a41c0356c4a0085fe7',
    messagingSenderId: '218597899046',
    projectId: 'account-database-f8f8a',
    storageBucket: 'account-database-f8f8a.appspot.com',
    androidClientId: '218597899046-h7cu072a9r6fnl9k9tidb87tt1rgf2d8.apps.googleusercontent.com',
    iosClientId: '218597899046-pqv0j44j9a4fkqv5unrrkh3jbrmg7eqh.apps.googleusercontent.com',
    iosBundleId: 'com.ncueY.ncueYproject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCpDeSY5Vo8XwYMIGhnGT0e1le6IsPe3u0',
    appId: '1:218597899046:ios:ae71a41c0356c4a0085fe7',
    messagingSenderId: '218597899046',
    projectId: 'account-database-f8f8a',
    storageBucket: 'account-database-f8f8a.appspot.com',
    androidClientId: '218597899046-h7cu072a9r6fnl9k9tidb87tt1rgf2d8.apps.googleusercontent.com',
    iosClientId: '218597899046-pqv0j44j9a4fkqv5unrrkh3jbrmg7eqh.apps.googleusercontent.com',
    iosBundleId: 'com.ncueY.ncueYproject',
  );
}