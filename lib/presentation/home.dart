import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nostressr/presentation/instruction_screen.dart';
import 'package:nostressr/presentation/stresstest_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _stressMessage = "Hi there";
  String _stressImage = "assets/gifs/animation_1_1_cat2_agadjbgaaq1fyfa.gif";

  Future<void> startStressTest() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screenInstruction()),
    );

    if (result != null && result is Map) {
      int questionnaireScore = result["questionnaireScore"];
      int reactionScore = result["reactionScore"];

      int finalScore = questionnaireScore + (reactionScore ~/ 100);
      // reaction ms scaled down

      String level = _getStressLevel(finalScore);
    }
  }

  String _getStressLevel(int score) {
    if (score <= 20) {
      _stressMessage = "Totally chill!";
      _stressImage = "assets/gifs/animation_1_1_cat2_agad_byaaqw8wfa.gif";
    } else if (score <= 35) {
      _stressMessage = "You’re doing fine.";
      _stressImage = "assets/gifs/animation_1_1_cat2_agadnrsaai1ayfa.gif";
    } else if (score <= 50) {
      _stressMessage = "A bit stressed, take a pause.";
      _stressImage = "assets/gifs/animation_1_1_cat2_agadrb4aajxmyfa.gif";
    } else if (score <= 65) {
      _stressMessage = "Feeling tense, try relaxing.";
      _stressImage = "assets/gifs/animation_1_1_cat2_agadvxgaalsayfa.gif";
    } else {
      _stressMessage = "Overloaded! Time to unwind.";
      _stressImage = "assets/gifs/kale_gerdali_1_0_agadqrcaahg0ofm.gif";
    }
    return _stressMessage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              if (_stressImage.isNotEmpty) ...[
                Column(
                  children: [
                    Image.asset(
                      _stressImage,
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _stressMessage,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: MediaQuery.of(context).size.height * 0.025,
                        color: Color.fromARGB(255, 162, 240, 244),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Container(
                width: MediaQuery.of(context).size.width * .9,
                height: MediaQuery.of(context).size.width * .2,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 253, 186, 226),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(
                        255,
                        162,
                        240,
                        244,
                      ).withOpacity(1), // shadow color
                      blurRadius: 20, // soften the shadow
                      spreadRadius: 7, // extend the shadow
                      offset: const Offset(0, 0), // X, Y movement
                    ),
                  ],
                ),
                child: ListTile(
                  onTap: startStressTest,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: Text(
                    'Check your stress level',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: MediaQuery.of(context).size.height * 0.025,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    'Know your current stress level based on a 10 question test and a reaction test',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: MediaQuery.of(context).size.height * 0.015,
                      color: Colors.black,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_right_outlined,
                    size: MediaQuery.of(context).size.width * .09,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
