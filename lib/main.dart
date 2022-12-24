import 'package:flutter/material.dart';
import 'MyHomePage.dart';
import 'RouterManager.dart';

void main() {
  RouterManager.DefineRoutes();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouterManager.router.generator,
      title: 'lost and found',
      home: MyHomePage(),
    );
  }

}

