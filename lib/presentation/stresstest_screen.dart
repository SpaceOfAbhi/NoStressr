import 'package:flutter/material.dart';
import 'package:nostressr/presentation/reactiontest_screen.dart';

class StressTestScreen extends StatefulWidget {
  @override
  _StressTestScreenState createState() => _StressTestScreenState();
}

class _StressTestScreenState extends State<StressTestScreen> {
  final List<String> questions = [
    "I feel nervous or anxious during the day.",
    "I have trouble relaxing even when I have free time.",
    "I feel irritated or annoyed more easily than usual.",
    "I find it hard to concentrate on tasks.",
    "I have trouble sleeping or don’t feel rested after sleep.",
    "I feel overwhelmed by daily responsibilities.",
    "I worry too much about things outside my control.",
    "I feel tired or low on energy most of the time.",
    "I avoid social interactions because of stress.",
    "I experience physical symptoms (headache, rapid heartbeat, etc.) due to stress.",
  ];

  List<int?> answers = [];

  @override
  void initState() {
    super.initState();
    answers = List.filled(questions.length, null);
  }

  int calculateScore() {
    return answers.whereType<int>().fold(0, (a, b) => a + b);
  }

  String getResultMessage(int score) {
    if (score <= 10)
      return "😎 Very Low Stress";
    else if (score <= 18)
      return "🙂 Low Stress";
    else if (score <= 26)
      return "😐 Moderate Stress";
    else if (score <= 34)
      return "😟 High Stress";
    else
      return "😫 Very High Stress";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: questions.length + 1, // extra item for button
          itemBuilder: (context, index) {
            if (index == questions.length) {
              // Last item → Button
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    int score = calculateScore();

                    // Go to ReactionTest and wait for its result
                    final reactionResult = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ReactionTestScreen(questionnaireScore: score),
                      ),
                    );

                    if (reactionResult != null) {
                      Navigator.pop(context, {
                        "questionnaireScore": score,
                        "reactionScore": reactionResult["reactionScore"],
                      });
                      Navigator.pop(context, {
                        "questionnaireScore": score,
                        "reactionScore": reactionResult["reactionScore"],
                      });
                    }
                  },
                  child: Text("Next"),
                ),
              );
            }

            // Question cards
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      questions[index],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(5, (option) {
                        return ChoiceChip(
                          label: Text("$option"),
                          selected: answers[index] == option,
                          onSelected: (selected) {
                            setState(() {
                              answers[index] = option;
                            });
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
