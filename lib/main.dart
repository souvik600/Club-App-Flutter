import 'package:flutter/material.dart';
import 'UserScreens/splash_screen.dart';


Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'মানব কল্যাণ যুব সংঘ',
      home: SplashScreen(),
    );
  }
}




