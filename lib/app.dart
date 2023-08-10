import 'package:flutter/material.dart';
import 'package:gratenote_app/screens/main_screen.dart';

class GrateNoteApp extends StatelessWidget {
  const GrateNoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GrateNote',
      theme: ThemeData(
        primaryColor: const Color(0xFF4A90E2), // A soft blue color
        scaffoldBackgroundColor: const Color(0xFFF3F7FA), // A very light blue background
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF4A90E2),
          secondary: Color(0xFFA8E6CF), // A gentle green color
          background: Color(0xFFF3F7FA),
          onPrimary: Colors.white,
          onSecondary: Colors.black,
        ),
        textTheme: const TextTheme(
          headline1: TextStyle(color: Color(0xFF4A90E2)),
          bodyText1: TextStyle(color: Color(0xFF576F7D)),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFF4A90E2),
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: const MainScreen(),
    );
  }
}
