import 'package:crafty_bay/app/app_theme.dart';
import 'package:flutter/material.dart';

import 'app_routes.dart';

class CraftyBayApp extends StatelessWidget {
  const CraftyBayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}


// Model, Screen/Widget, Controllers -> Layer First
// Feature First -> features - auth - model/presentation/controller