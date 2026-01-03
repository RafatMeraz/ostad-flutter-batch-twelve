import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:live_score_app/fcm_service.dart';
import 'package:live_score_app/home_screen.dart';
import 'package:live_score_app/sign_in_screen.dart';
import 'package:live_score_app/sign_up_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FcmService.initialize();

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
