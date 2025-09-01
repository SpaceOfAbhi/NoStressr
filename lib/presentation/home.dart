import 'package:flutter/material.dart';
import 'package:nostressr/presentation/stresstest_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _stressResult = "Take the test to see your stress level!";

  Future<void> _startStressTest() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StressTestScreen()),
    );

    if (result != null && result is Map) {
      int questionnaireScore = result["questionnaireScore"];
      int reactionScore = result["reactionScore"];

      int finalScore = questionnaireScore + (reactionScore ~/ 100);
      // reaction ms scaled down

      String level = _getStressLevel(finalScore);

      setState(() {
        _stressResult = level;
      });
    }
  }

  String _getStressLevel(int score) {
    if (score <= 20) return "😎 Very Low Stress";
    if (score <= 35) return "🙂 Low Stress";
    if (score <= 50) return "😐 Moderate Stress";
    if (score <= 65) return "😟 High Stress";
    return "😫 Very High Stress";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _stressResult,
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _startStressTest,
              child: Text("Start Stress Test"),
            ),
          ],
        ),
      ),
    );
  }
}
