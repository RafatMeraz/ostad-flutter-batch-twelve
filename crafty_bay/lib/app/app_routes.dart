import 'package:flutter/material.dart';

import '../features/auth/presentation/screens/sign_in_screen.dart';
import '../features/auth/presentation/screens/sign_up_screen.dart';
import '../features/auth/presentation/screens/splash_screen.dart';
import '../features/auth/presentation/screens/verify_otp_screen.dart';
import '../features/products/presentation/screens/product_details_screen.dart';
import '../features/products/presentation/screens/product_list_screen.dart';
import '../features/shared/presentation/screens/main_nav_holder_screen.dart';

class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    Widget widget = SizedBox();
    switch (settings.name) {
      case SplashScreen.name:
        widget = const SplashScreen();
        break;
      case SignUpScreen.name:
        widget = const SignUpScreen();
        break;
      case SignInScreen.name:
        widget = const SignInScreen();
        break;
      case VerifyOtpScreen.name:
        widget = const VerifyOtpScreen();
        break;
      case MainNavHolderScreen.name:
        widget = const MainNavHolderScreen();
        break;
      case ProductListScreen.name:
        final categoryName = settings.arguments as String;
        widget = ProductListScreen(categoryName: categoryName);
        break;
      case ProductDetailsScreen.name:
        widget = ProductDetailsScreen();
        break;
    }
    return MaterialPageRoute(builder: (context) => widget);
  }
}