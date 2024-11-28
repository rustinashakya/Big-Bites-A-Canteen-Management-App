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
    apiKey: 'AIzaSyDcwjOYG7KLvXpmU6mig1CzueGpc5AGO6g',
    appId: '1:581467261389:web:f2d607bc7cd315077ddc84',
    messagingSenderId: '581467261389',
    projectId: 'big-bites-9a86f',
    authDomain: 'big-bites-9a86f.firebaseapp.com',
    storageBucket: 'big-bites-9a86f.firebasestorage.app',
    measurementId: 'G-XFBY6WFFVJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCZbIHwDqfUuuz2M_ClXGf1l1eCjEKzKWE',
    appId: '1:581467261389:android:9255832289321dcf7ddc84',
    messagingSenderId: '581467261389',
    projectId: 'big-bites-9a86f',
    storageBucket: 'big-bites-9a86f.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAqXomjXOKfvrmbX2_CL_x--ed2Fk653J0',
    appId: '1:581467261389:ios:819fc4e7ddaa100e7ddc84',
    messagingSenderId: '581467261389',
    projectId: 'big-bites-9a86f',
    storageBucket: 'big-bites-9a86f.firebasestorage.app',
    iosBundleId: 'com.example.bigBites',
  );
}
