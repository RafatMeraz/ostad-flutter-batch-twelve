import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:live_score_app/fcm_service.dart';
import 'package:live_score_app/home_screen.dart';
import 'package:live_score_app/sign_in_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  FirebaseCrashlytics.instance.setCustomKey('userId', 12);
  FirebaseCrashlytics.instance.setCustomKey('userRole', 'guest');

  await FcmService.initialize();

  // Initialize the Mobile Ads SDK.
  MobileAds.instance.initialize();

  print(await FcmService.getToken());

  FcmService.listenTokenOnChange();

  runApp(const LiveScoreApp());
}

class LiveScoreApp extends StatelessWidget {
  const LiveScoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.data != null) {
            return HomeScreen();
          } else {
            return SignInScreen();
          }
        }
      ),
    );
  }
}
