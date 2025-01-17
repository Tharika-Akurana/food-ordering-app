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
    apiKey: 'AIzaSyD39IoFgin3yJnk2PEXIdNNoFHtVSdY_NU',
    appId: '1:940638865663:android:1222d7251cac084e2ca4ca',
    messagingSenderId: '940638865663',
    projectId: 'mern-hotel-booking-app-8f88d',
    storageBucket: 'mern-hotel-booking-app-8f88d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC5svrfc1Tms8Fb-ZhwtQTU_j1OLeX9AhA',
    appId: '1:940638865663:ios:4acc2320a2e2941e2ca4ca',
    messagingSenderId: '940638865663',
    projectId: 'mern-hotel-booking-app-8f88d',
    storageBucket: 'mern-hotel-booking-app-8f88d.appspot.com',
    iosClientId: '940638865663-1q770mupo1alplorsc5t5kclp894la47.apps.googleusercontent.com',
    iosBundleId: 'com.example.foodOrderingCustomerapp',
  );
}
