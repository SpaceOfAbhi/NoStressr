import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nostressr/presentation/stresstest_screen.dart';

class screenInstruction extends StatelessWidget {
  const screenInstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'INSTRUCTION',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 40,
                color: Color.fromARGB(255, 253, 186, 226),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Text(
              'You will be asked 10 simple questions ',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 20,
                color: Color.fromARGB(255, 162, 240, 244),
              ),
            ),
            Text(
              'about your daily stress, mood, and habits.',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 20,
                color: Color.fromARGB(255, 162, 240, 244),
              ),
            ),
            Text(
              'Choose option that describes your current state.',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 20,
                color: Color.fromARGB(255, 162, 240, 244),
              ),
            ),
            Text(
              'Then you will see a red screen.',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 20,
                color: Color.fromARGB(255, 162, 240, 244),
              ),
            ),
            Text(
              'When the color changes to green,',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 20,
                color: Color.fromARGB(255, 162, 240, 244),
              ),
            ),
            Text(
              'tap the screen as fast as possible.',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 20,
                color: Color.fromARGB(255, 162, 240, 244),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),

            Text(
              'Stay focused — false taps before the signal won’t count.',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 15,
                color: Color.fromARGB(255, 253, 186, 226),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),

            SizedBox(
              height: MediaQuery.of(context).size.height * .055,
              width: MediaQuery.of(context).size.width * .250,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 162, 240, 244),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StressTestScreen()),
                  );
                },
                child: Text(
                  'Start',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: MediaQuery.of(context).size.height * .02,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
