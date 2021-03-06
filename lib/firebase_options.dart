// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAznUT5Spz4tov5mUy_5XPxxxxxxxxxxxx',
    appId: '1:162603779372:android:ad893ac60bb3c34cf7d889',
    messagingSenderId: '162603779372',
    projectId: 'gdsc-gateway',
    storageBucket: 'gdsc-gateway.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCkq1dY4pLqQG8c0r5W3L_xxxxxxxxxxxx',
    appId: '1:162603779372:ios:bc1c5e51985b7391f7d889',
    messagingSenderId: '162603779372',
    projectId: 'gdsc-gateway',
    storageBucket: 'gdsc-gateway.appspot.com',
    iosClientId:
        '162603779372-08lnf5dhenlc5dgrerqk8bj02caq511u.apps.googleusercontent.com',
    iosBundleId: 'com.gdschsu.gateway',
  );
}
