import 'package:final_project/routes/routes.dart';
import 'package:flutter/material.dart';

import './screens/login.screen.dart';

void main() { runApp(const MyApp()); }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Final Project',
      initialRoute: LoginScreen.routeName,
      routes: routes,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: LoginScreen(),
    );
  }
}
