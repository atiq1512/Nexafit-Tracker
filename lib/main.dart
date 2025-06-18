// main.dart
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'bmi_page.dart';
import 'timer_page.dart';
import 'calorie_page.dart';

void main() => runApp(FitnessApp());

class FitnessApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Tracker',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => AuthPage(),
        '/bmi': (context) => BMIPage(),
        '/timer': (context) => TimerPage(activity: '',),
        '/calories': (context) => CaloriePage(),
      },
    );
  }
}
