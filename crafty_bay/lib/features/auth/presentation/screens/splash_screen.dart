import 'package:crafty_bay/app/extensions/localization_extension.dart';
import 'package:crafty_bay/app/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final languageProvider = context.read<LanguageProvider>();

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.hello)),
      body: Column(
        children: [
          // FilledButton(
          //   onPressed: () {
          //     Locale locale = context.read<LanguageProvider>().currentLocale;
          //     if (locale == Locale('en')) {
          //       context.read<LanguageProvider>().changeLocale(Locale('bn'));
          //     } else {
          //       context.read<LanguageProvider>().changeLocale(Locale('en'));
          //     }
          //   },
          //   child: Text('Change Language'),
          // ),
          Text(context.l10n.changeYourLanguage),
          DropdownMenu<Locale>(
            dropdownMenuEntries: languageProvider.supportedLocales.map((e) {
              return DropdownMenuEntry(value: e, label: e.languageCode);
            }).toList(),
            initialSelection: languageProvider.currentLocale,
            onSelected: (value) {
              languageProvider.changeLocale(value!);
            },
          ),
        ],
      ),
    );
  }
}
