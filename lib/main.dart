import 'package:flutter/material.dart';
import 'package:adhicine/view/screens/splash_screen.dart';
import 'package:adhicine/view/screens/sign_in_screen.dart';
import 'package:adhicine/view/screens/sign_up_screen.dart';
import 'package:adhicine/view/screens/add_medicine_screen.dart';
import 'package:adhicine/view/screens/home_screen.dart';
import 'package:adhicine/view/screens/report_screen.dart';
import 'package:adhicine/view/screens/settings_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adhicine',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), // Start with Splash Screen
      routes: {
        '/signin': (context) => SignInScreen(),
        '/signup': (context) => SignUpScreen(),
        '/home': (context) => HomeScreen(),
        '/addMedicine': (context) => AddMedicineScreen(),
        '/report': (context) => ReportScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}
