import 'package:crafty_bay/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

import '../core/services/network_caller.dart';
import '../features/auth/presentation/screens/sign_in_screen.dart';
import 'crafty_bay_app.dart';

NetworkCaller getNetworkCaller() {
  return NetworkCaller(
    headers: () {
      Map<String, String> headers = {
        'content-type': 'application/json',
      };
      if (AuthController.token != null) {
        headers['token'] = '${AuthController.token}';
      }
      return headers;
    },
    onUnauthorize: () async {
      await AuthController.clearUserData();
      _moveToSignInScreen();
    },
  );
}



void _moveToSignInScreen() {
  Navigator.pushNamed(
    CraftyBayApp.navigatorKey.currentContext!,
    SignInScreen.name,
  );
}
