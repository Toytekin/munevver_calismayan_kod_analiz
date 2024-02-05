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
    apiKey: 'AIzaSyBs3JtI2D6IQ9gkfwaBjZA0BKVHz85fTDA',
    appId: '1:222373362005:web:46d7f4b2d8dce73dafd7dc',
    messagingSenderId: '222373362005',
    projectId: 'munevver-abc10',
    authDomain: 'munevver-abc10.firebaseapp.com',
    storageBucket: 'munevver-abc10.appspot.com',
    measurementId: 'G-WVC6FQ22YL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAUq7rh32rsaJWidKODHvfhOZt8_1uBOgg',
    appId: '1:222373362005:android:b1e62958b026bec1afd7dc',
    messagingSenderId: '222373362005',
    projectId: 'munevver-abc10',
    storageBucket: 'munevver-abc10.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCq67UzCebyl24QvVE-Oyo7EebpM84ovPQ',
    appId: '1:222373362005:ios:6c3325dfc087e256afd7dc',
    messagingSenderId: '222373362005',
    projectId: 'munevver-abc10',
    storageBucket: 'munevver-abc10.appspot.com',
    iosBundleId: 'com.example.sosyalAppMunevver',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCq67UzCebyl24QvVE-Oyo7EebpM84ovPQ',
    appId: '1:222373362005:ios:6c3325dfc087e256afd7dc',
    messagingSenderId: '222373362005',
    projectId: 'munevver-abc10',
    storageBucket: 'munevver-abc10.appspot.com',
    iosBundleId: 'com.example.sosyalAppMunevver',
  );
}
