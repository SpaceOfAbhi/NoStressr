import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nostressr/presentation/home.dart';
import 'package:nostressr/presentation/login_screen.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    super.initState();
    waitSplash();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.height * .2,
          child: Image.asset(
            'assets/logo/Stress_Buster__3_-removebg-preview.png',
            scale: 2,
          ),
        ),
      ),
    );
  }

  waitSplash() async {
    await Future.delayed(const Duration(seconds: 3));

    // Check if user is logged in
    final user = FirebaseAuth.instance.currentUser;

    Widget nextScreen;
    if (user != null) {
      nextScreen = const HomeScreen(); // User already logged in
    } else {
      nextScreen = screenLogin(); // Not logged in
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(seconds: 1),
        reverseTransitionDuration: const Duration(seconds: 1),
        pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }
}
