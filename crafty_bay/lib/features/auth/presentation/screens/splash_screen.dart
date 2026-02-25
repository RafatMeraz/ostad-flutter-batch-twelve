import 'package:flutter/material.dart';

import '../../../shared/presentation/screens/main_nav_holder_screen.dart';
import '../widgets/app_logo.dart';
import 'sign_up_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacementNamed(context, SignUpScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(child: Center(child: AppLogo(height: 120))),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
