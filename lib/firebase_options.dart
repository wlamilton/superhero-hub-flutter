import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        throw UnsupportedError(
          'DefaultFirebaseOptions não foi configurado para Android ainda.',
        );
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions não foi configurado para iOS ainda.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions não foi configurado para macOS ainda.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions não foi configurado para Windows ainda.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions não foi configurado para Linux ainda.',
        );
      default:
        throw UnsupportedError(
          'Plataforma não suportada.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB6u07fcbyNUnQTaz14xi69vdYI-p2_l5o',
    appId: '1:799690155352:web:ecbf189455864e9c0f712d',
    messagingSenderId: '799690155352',
    projectId: 'superhero-firebase-app',
    authDomain: 'superhero-firebase-app.firebaseapp.com',
    storageBucket: 'superhero-firebase-app.firebasestorage.app',
    measurementId: 'G-HL662552NZ',
  );
}
