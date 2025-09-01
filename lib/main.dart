import 'package:flutter/material.dart';
import 'package:nostressr/presentation/login_screen.dart';
import 'package:nostressr/presentation/signup_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: screenSignup());
  }
}
