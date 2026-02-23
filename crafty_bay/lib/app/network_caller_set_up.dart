import 'package:flutter/material.dart';

import '../core/services/network_caller.dart';
import '../features/auth/presentation/screens/sign_in_screen.dart';
import 'crafty_bay_app.dart';

NetworkCaller getNetworkCaller() {
  return NetworkCaller(
    headers: {'token': 'token', 'content-type': 'application/json'},
    onUnauthorize: () {
      // TODO: Clear user data
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
