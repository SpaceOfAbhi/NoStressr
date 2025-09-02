import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nostressr/infrastructure/db_functions.dart';
import 'package:nostressr/model/user_model.dart';
import 'package:nostressr/presentation/home.dart';
import 'package:nostressr/presentation/signup_screen.dart';

class screenLogin extends StatelessWidget {
  screenLogin({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _loginAFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Form(
          key: _loginAFormKey,
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
                      controller: emailController,
                      // ignore: body_might_complete_normally_nullable
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email required';
                        }
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
                      controller: passwordController,
                      obscureText: true,
                      // ignore: body_might_complete_normally_nullable
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email required';
                        }
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
                  SizedBox(height: MediaQuery.of(context).size.height * .03),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .055,
                    width: MediaQuery.of(context).size.width * .250,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 253, 186, 226),
                      ),
                      onPressed: () async {
                        Usermodel u = Usermodel(
                          '',
                          '',
                          emailController.text,
                          passwordController.text,
                        );
                        bool isloggedin = await checklogin(u);
                        if (isloggedin) {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              transitionDuration: const Duration(milliseconds: 150),
                              reverseTransitionDuration: const Duration(
                                seconds: 1,
                              ),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      HomeScreen(),
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
                          final snackbar = SnackBar(
                            content: Text('loggin failed'),
                            action: SnackBarAction(
                              label: 'Close',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        }
                      },
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: const Duration(
                                milliseconds: 70,
                              ),
                              reverseTransitionDuration: const Duration(
                                milliseconds: 70,
                              ),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      screenSignup(),
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
                        },
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
      ),
    );
  }
}
