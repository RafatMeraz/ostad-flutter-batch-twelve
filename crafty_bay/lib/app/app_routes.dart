import 'package:flutter/material.dart';

import '../features/auth/presentation/screens/splash_screen.dart';

class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    Widget widget = SizedBox();
    switch (settings.name) {
      case '/':
        widget = const SplashScreen();
        break;
    }
    return MaterialPageRoute(builder: (context) => widget);
  }
}