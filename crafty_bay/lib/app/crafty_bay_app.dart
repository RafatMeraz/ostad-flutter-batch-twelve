import 'package:crafty_bay/app/app_theme.dart';
import 'package:crafty_bay/app/providers/language_provider.dart';
import 'package:crafty_bay/features/home/presentation/providers/home_slider_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../features/category/presentation/providers/category_list_provider.dart';
import '../features/shared/presentation/providers/main_nav_provider.dart';
import '../l10n/app_localizations.dart';
import 'app_routes.dart';

// TODO: Add Theme Mode Change Provider

class CraftyBayApp extends StatelessWidget {
  const CraftyBayApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => MainNavProvider()),
        ChangeNotifierProvider(create: (context) => HomeSliderProvider()),
        ChangeNotifierProvider(create: (context) => CategoryListProvider()),
      ],
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            initialRoute: '/',
            onGenerateRoute: AppRoutes.onGenerateRoute,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            locale: languageProvider.currentLocale,
            supportedLocales: languageProvider.supportedLocales,
            themeMode: .light,
          );
        }
      ),
    );
  }
}