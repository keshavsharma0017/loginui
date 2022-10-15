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
    apiKey: 'AIzaSyAYof_QoRFrCLloQymxamX9iX7jn259mmw',
    appId: '1:923985050356:web:2c282d2980b3302e26fca1',
    messagingSenderId: '923985050356',
    projectId: 'my-login-ui',
    authDomain: 'my-login-ui.firebaseapp.com',
    storageBucket: 'my-login-ui.appspot.com',
    measurementId: 'G-KHYCMKGNDT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCf31lvytWtGqnWl4b-RTAjZR9sgBbzBFs',
    appId: '1:923985050356:android:8980ce2a493bdc6a26fca1',
    messagingSenderId: '923985050356',
    projectId: 'my-login-ui',
    storageBucket: 'my-login-ui.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBFSJido2RAEQk0T2NhEmhYCcKQ8fDlwh8',
    appId: '1:923985050356:ios:a0452ff6992df59e26fca1',
    messagingSenderId: '923985050356',
    projectId: 'my-login-ui',
    storageBucket: 'my-login-ui.appspot.com',
    iosClientId: '923985050356-bqa03s2mn8qsaa3f06qb7okr3b2f007u.apps.googleusercontent.com',
    iosBundleId: 'com.example.loginUi',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBFSJido2RAEQk0T2NhEmhYCcKQ8fDlwh8',
    appId: '1:923985050356:ios:a0452ff6992df59e26fca1',
    messagingSenderId: '923985050356',
    projectId: 'my-login-ui',
    storageBucket: 'my-login-ui.appspot.com',
    iosClientId: '923985050356-bqa03s2mn8qsaa3f06qb7okr3b2f007u.apps.googleusercontent.com',
    iosBundleId: 'com.example.loginUi',
  );
}
