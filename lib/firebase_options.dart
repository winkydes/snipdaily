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
    apiKey: 'AIzaSyBLZpJOMYAYtqRbG291LG8fUSqJlcm4AcA',
    appId: '1:943530903500:web:003e149f42504998cb3f69',
    messagingSenderId: '943530903500',
    projectId: 'snip-daily',
    authDomain: 'snip-daily.firebaseapp.com',
    storageBucket: 'snip-daily.appspot.com',
    measurementId: 'G-DPBYBRDMK6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCu8qN0SdZI4BfriWOf0dKLSxLqOcfilNU',
    appId: '1:943530903500:android:d779fc51d7d4ab01cb3f69',
    messagingSenderId: '943530903500',
    projectId: 'snip-daily',
    storageBucket: 'snip-daily.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAXOlF6CR_uRDjdaL2fNcbYzhVMTFF6a7Q',
    appId: '1:943530903500:ios:916eaffb0c844320cb3f69',
    messagingSenderId: '943530903500',
    projectId: 'snip-daily',
    storageBucket: 'snip-daily.appspot.com',
    iosClientId: '943530903500-8jgs5m2romr8s78a3lg6fnm0l9m8g08d.apps.googleusercontent.com',
    iosBundleId: 'com.example.snipdaily',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAXOlF6CR_uRDjdaL2fNcbYzhVMTFF6a7Q',
    appId: '1:943530903500:ios:916eaffb0c844320cb3f69',
    messagingSenderId: '943530903500',
    projectId: 'snip-daily',
    storageBucket: 'snip-daily.appspot.com',
    iosClientId: '943530903500-8jgs5m2romr8s78a3lg6fnm0l9m8g08d.apps.googleusercontent.com',
    iosBundleId: 'com.example.snipdaily',
  );
}