import 'package:flutter/material.dart';

class screenTest extends StatefulWidget {
  const screenTest({super.key});

  @override
  State<screenTest> createState() => _screenTestState();
}

class _screenTestState extends State<screenTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          'assets/gifs/animation_1_1_cat2_agadvxgaalsayfa.gif',
        ),
      ),
    );
  }
}
