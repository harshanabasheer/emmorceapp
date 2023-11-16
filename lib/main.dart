import 'package:flutter/material.dart';
import 'design/splash.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme:  ThemeData(
        primaryColor: Colors.deepPurple,
        hintColor: Colors.cyan[600],
        fontFamily: 'Roboto',
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          headline2: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          bodyText1: TextStyle(fontSize: 16),
          bodyText2: TextStyle(fontSize: 14),
        ),
      ),
      home: const SplashScreen(),

    );
  }
}

