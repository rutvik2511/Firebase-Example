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
    apiKey: 'AIzaSyDwtHvzIn-j-c0PUYF6c70DO5ej_uYued8',
    appId: '1:735112696743:web:9b2b1320f065433c83dc82',
    messagingSenderId: '735112696743',
    projectId: 'fir-task-45788',
    authDomain: 'fir-task-45788.firebaseapp.com',
    storageBucket: 'fir-task-45788.appspot.com',
    measurementId: 'G-LJMJYLBR2T',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDk6YEQItv_Irp151p1hyF7pgCrA87onvM',
    appId: '1:735112696743:android:c2b28e8e24d9e70883dc82',
    messagingSenderId: '735112696743',
    projectId: 'fir-task-45788',
    storageBucket: 'fir-task-45788.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDtmMH8BwC3mjtcytx_qWiLQK8BbbmEj_U',
    appId: '1:735112696743:ios:5bf0d953995cb48183dc82',
    messagingSenderId: '735112696743',
    projectId: 'fir-task-45788',
    storageBucket: 'fir-task-45788.appspot.com',
    androidClientId: '735112696743-ob89fhg9alpcegolmuvkpj4fnb50qg6q.apps.googleusercontent.com',
    iosClientId: '735112696743-mmc2v2e7ceailedmn2vrn9j2cn9c902u.apps.googleusercontent.com',
    iosBundleId: 'com.example.task2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDtmMH8BwC3mjtcytx_qWiLQK8BbbmEj_U',
    appId: '1:735112696743:ios:5bf0d953995cb48183dc82',
    messagingSenderId: '735112696743',
    projectId: 'fir-task-45788',
    storageBucket: 'fir-task-45788.appspot.com',
    androidClientId: '735112696743-ob89fhg9alpcegolmuvkpj4fnb50qg6q.apps.googleusercontent.com',
    iosClientId: '735112696743-mmc2v2e7ceailedmn2vrn9j2cn9c902u.apps.googleusercontent.com',
    iosBundleId: 'com.example.task2',
  );
}
