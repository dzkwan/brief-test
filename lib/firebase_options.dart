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
    apiKey: 'AIzaSyDaZlMRYlUIrJGOBkElJ6nQb_AcYxZcdJ0',
    appId: '1:695096071921:web:b97973be575c54ea3bbb50',
    messagingSenderId: '695096071921',
    projectId: 'authbrieftest',
    authDomain: 'authbrieftest.firebaseapp.com',
    storageBucket: 'authbrieftest.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDYIwDWuQibwFBxAZ5T6YeyxamVJTZ-dlU',
    appId: '1:695096071921:android:ca43fdce2e5b99243bbb50',
    messagingSenderId: '695096071921',
    projectId: 'authbrieftest',
    storageBucket: 'authbrieftest.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBDDNMfY4o71xRVaRTOwd7611-w_7VUHd4',
    appId: '1:695096071921:ios:aa6063933f988e6b3bbb50',
    messagingSenderId: '695096071921',
    projectId: 'authbrieftest',
    storageBucket: 'authbrieftest.appspot.com',
    iosBundleId: 'com.example.brieftest',
  );
}
