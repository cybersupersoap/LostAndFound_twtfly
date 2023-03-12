import 'package:flutter/material.dart';
import 'MyHomePage.dart';
import 'RouterManager.dart';
import 'Cache.dart';

void main() {
  RouterManager.DefineRoutes();
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey= new GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      onGenerateRoute: RouterManager.router.generator,
      title: 'lost and found',
      home: MyHomePage(),
    );
  }

}

