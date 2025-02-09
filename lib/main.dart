import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:prime_alert/core/di/service_locator.dart';
import 'package:prime_alert/core/theme/dark_theme.dart';
import 'package:prime_alert/features/clock/view/clock_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator.setupLocator(await SharedPreferences.getInstance());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prime Alert',
      theme: darkTheme,
      supportedLocales: const [
        Locale('de', 'DE'),
        Locale('en', 'US'), // Add fallback if needed
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Prime Alert'),
        ),
        body: const ClockScreen(),
      ),
    );
  }
}
