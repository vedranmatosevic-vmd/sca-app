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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD9CqTgEEvddlWPSM1QqNr3RMrmEtTRW7E',
    appId: '1:155776666149:android:2f20701763430587a64dcc',
    messagingSenderId: '155776666149',
    projectId: 'sca-app-227dc',
    databaseURL: 'https://sca-app-227dc-default-rtdb.firebaseio.com',
    storageBucket: 'sca-app-227dc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB5Ym9Mq6LA-asiZkCe868j-SODbKl7hGs',
    appId: '1:155776666149:ios:1447f51e0ad4244fa64dcc',
    messagingSenderId: '155776666149',
    projectId: 'sca-app-227dc',
    databaseURL: 'https://sca-app-227dc-default-rtdb.firebaseio.com',
    storageBucket: 'sca-app-227dc.appspot.com',
    iosClientId: '155776666149-9o7tcr3vju0gbq94knhtk7q9f0qcpjlu.apps.googleusercontent.com',
    iosBundleId: 'com.sportclub.admin.scaApp',
  );
}