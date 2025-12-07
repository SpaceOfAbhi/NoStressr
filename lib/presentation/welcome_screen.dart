import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nostressr/presentation/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScreenWelcome extends StatefulWidget {
  const ScreenWelcome({super.key});

  @override
  State<ScreenWelcome> createState() => _ScreenWelcomeState();
}

class _ScreenWelcomeState extends State<ScreenWelcome> {
  String? userName;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUserName();
  }

  Future<void> loadUserName() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      if (userDoc.exists) {
        setState(() {
          userName = userDoc.data()?['user_name'] ?? "User"; // ✅ correct field
          isLoading = false;
        });
      } else {
        setState(() {
          userName = "User";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        userName = "User";
        isLoading = false;
      });
    }
  }

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
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              Text(
                isLoading ? "Loading..." : "Hi $userName, Welcome",
                style: GoogleFonts.spaceGrotesk(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
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
                    width: MediaQuery.of(context).size.height * 0.2,
                    child: Image.asset(
                      'assets/logo/Stress_Buster__3_-removebg-preview.png',
                      scale: 2,
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                'From stress check to stress relief',
                style: GoogleFonts.spaceGrotesk(
                  color: Color.fromARGB(255, 162, 240, 244),
                  fontSize: 20,
                ),
              ),
              Text(
                ' — all in one app',
                style: GoogleFonts.spaceGrotesk(
                  color: Color.fromARGB(255, 253, 186, 226),
                  fontSize: 20,
                ),
              ),
              Spacer(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 162, 240, 244),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 300),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            HomeScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                      ),
                    );
                  },
                  child: Text(
                    'Get started',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: MediaQuery.of(context).size.height * 0.025,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
