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
    apiKey: 'AIzaSyAF5TLIlSaVlR-pwehm2h2tnjXTvo8zLmc',
    appId: '1:39526709654:web:131be09f7bc6237072c5b7',
    messagingSenderId: '39526709654',
    projectId: 'medical-data-77e73',
    authDomain: 'medical-data-77e73.firebaseapp.com',
    storageBucket: 'medical-data-77e73.appspot.com',
    measurementId: 'G-JPH8VSDNRT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBerKVNtgpT8fOSuqE9cjDtt0xYYZv1Jpo',
    appId: '1:39526709654:android:0340a003daa53d2672c5b7',
    messagingSenderId: '39526709654',
    projectId: 'medical-data-77e73',
    storageBucket: 'medical-data-77e73.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC2lcad_EIMqIqTDdQ0eksWyyharmTjye0',
    appId: '1:39526709654:ios:560c53323d7ca6df72c5b7',
    messagingSenderId: '39526709654',
    projectId: 'medical-data-77e73',
    storageBucket: 'medical-data-77e73.appspot.com',
    iosBundleId: 'com.example.medicalapp1',
  );
}
