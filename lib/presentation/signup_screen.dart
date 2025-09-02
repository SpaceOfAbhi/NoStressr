import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nostressr/infrastructure/db_functions.dart';
import 'package:nostressr/model/user_model.dart';
import 'package:nostressr/presentation/login_screen.dart';
import 'package:nostressr/presentation/welcome_screen.dart';

class screenSignup extends StatelessWidget {
  screenSignup({super.key});
  final userNameController = TextEditingController();
  final userEmailController = TextEditingController();
  final userPasswordController = TextEditingController();
  final userPasswordReconfirmController = TextEditingController();
  final _regFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Form(
          key: _regFormKey,
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * .2),
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
                      controller: userNameController,
                      validator: (value) {
                        if (value!.isEmpty) return 'Name required';
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 162, 240, 244),
                        hintText: '   User name',
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
                      controller: userEmailController,
                      validator: (value) {
                        if (value!.isEmpty) return 'Email required';
                        return null;
                      },
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
                      controller: userPasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'password required';
                        } else if (value.length < 8) {
                          return 'minimum length 8';
                        }
                        return null;
                      },
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
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .8,

                    child: TextFormField(
                      controller: userPasswordReconfirmController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password required';
                        } else if (value != userPasswordController.text) {
                          return 'Passwords mismatch';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 162, 240, 244),
                        hintText: '   Retype Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .03),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .055,
                    width: MediaQuery.of(context).size.width * .350,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 253, 186, 226),
                      ),
                      onPressed: () async {
                        if (_regFormKey.currentState!.validate()) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Colors.pink,
                                ),
                              );
                            },
                          );
                          Usermodel s = Usermodel(
                            '',
                            userNameController.text,
                            userEmailController.text,
                            userPasswordController.text,
                          );
                          bool result = await addUser(s);
                          if (result) {
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                transitionDuration: const Duration(seconds: 1),
                                reverseTransitionDuration: const Duration(
                                  seconds: 1,
                                ),
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        ScreenWelcome(),
                                transitionsBuilder:
                                    (
                                      context,
                                      animation,
                                      secondaryAnimation,
                                      child,
                                    ) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                              ),
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("SignUp Failed"),
                                  content: const Text(
                                    "Something went wrong. Please try again.",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("OK"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }
                      },
                      child: Text(
                        'Create Account',
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
          ),
        ),
      ),
    );
  }
}
