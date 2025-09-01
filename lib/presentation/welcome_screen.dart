import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class screenWelcome extends StatelessWidget {
  const screenWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .15,
                ),
                child: Text(
                  'Hi , Welcome',
                  style: GoogleFonts.spaceGrotesk(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'to',
                    style: GoogleFonts.spaceGrotesk(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.height * .2,
                    child: Image.asset(
                      'assets/logo/Stress_Buster__3_-removebg-preview.png',
                      scale: 2,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .05,
                ),
                child: Text(
                  'From stress check to stress relief',

                  style: GoogleFonts.spaceGrotesk(
                    color: Color.fromARGB(255, 162, 240, 244),
                    fontSize: 20,
                  ),
                ),
              ),
              Text(
                ' — all in one app',
                style: GoogleFonts.spaceGrotesk(
                  color: Color.fromARGB(255, 253, 186, 226),
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .45,
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .08,
                  width: MediaQuery.of(context).size.width * .90,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 162, 240, 244),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Get started',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: MediaQuery.of(context).size.height * .025,
                        color: Colors.black,
                      ),
                    ),
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
