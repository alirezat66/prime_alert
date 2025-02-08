import 'package:flutter/material.dart';
import 'package:prime_alert/core/di/service_locator.dart';
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
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Prime Alert'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
