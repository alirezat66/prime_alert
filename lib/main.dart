import 'package:flutter/material.dart';
import 'package:prime_alert/core/di/di_setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prime Alert',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Prime Alert'),
        ),
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
