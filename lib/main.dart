import 'package:edu_watch/features/main_home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const EduWatchApp());
}

class EduWatchApp extends StatelessWidget {
  const EduWatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduWatch',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Color(0xFFE9435A),
        primaryColorLight: Colors.blue,
        errorColor: Colors.red,
      ),
      home: SignInScreen(),
    );
  }
}
