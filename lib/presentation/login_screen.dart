import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class screenLogin extends StatelessWidget {
  const screenLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .3),
                SizedBox(
                  width: MediaQuery.of(context).size.height * .2,
                  child: Image.asset(
                    'assets/logo/Stress_Buster__3_-removebg-preview.png',
                    scale: 2,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .05),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .8,
                  child: TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 162, 240, 244),
                      hintText: '   Email address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .02),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .8,

                  child: TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 162, 240, 244),
                      hintText: '   Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .03),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .055,
                  width: MediaQuery.of(context).size.width * .250,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 253, 186, 226),
                    ),
                    onPressed: () {},
                    child: Text(
                      'LOGIN',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: MediaQuery.of(context).size.height * .025,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dont have an account?',
                      style: GoogleFonts.spaceGrotesk(
                        color: Color.fromARGB(255, 162, 240, 244),
                        fontSize: 15,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'SignUp',
                        style: GoogleFonts.spaceGrotesk(
                          color: Color.fromARGB(255, 253, 186, 226),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
