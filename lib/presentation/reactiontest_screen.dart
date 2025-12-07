import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:nostressr/infrastructure/db_functions.dart';

class ReactionTestScreen extends StatefulWidget {
  final int questionnaireScore;

  ReactionTestScreen({required this.questionnaireScore});

  @override
  _ReactionTestScreenState createState() => _ReactionTestScreenState();
}

class _ReactionTestScreenState extends State<ReactionTestScreen> {
  Color _bgColor = Colors.red;
  String _message = "Wait for Green...";
  bool _waitingForTap = false;
  Stopwatch _stopwatch = Stopwatch();
  int? _reactionTime;

  void _startTest() {
    setState(() {
      _bgColor = Colors.red;
      _message = "Wait for Green...";
      _reactionTime = null;
    });

    // Wait random time (2–5 seconds) before turning green
    Future.delayed(Duration(seconds: Random().nextInt(4) + 2), () {
      setState(() {
        _bgColor = Colors.green;
        _message = "TAP!";
        _waitingForTap = true;
      });
      _stopwatch.reset();
      _stopwatch.start();
    });
  }

  void _handleTap() {
    if (_waitingForTap) {
      _stopwatch.stop();
      setState(() {
        _reactionTime = _stopwatch.elapsedMilliseconds;
        _waitingForTap = false;
        _bgColor = Colors.blue;
        _message = "Your reaction: $_reactionTime ms";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _startTest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _handleTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          color: _bgColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _message,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                if (_reactionTime != null)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, {
                        "questionnaireScore": widget.questionnaireScore,
                        "reactionScore": _reactionTime!,
                      });
                    },
                    child: Text("Finish"),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
