import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nostressr/presentation/click_button.dart';
import 'package:nostressr/presentation/funny_button.dart';
import 'package:nostressr/presentation/instruction_screen.dart';
import 'package:nostressr/presentation/login_screen.dart';
import 'package:nostressr/presentation/onoff_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? lastTested;
  @override
  void initState() {
    super.initState();
    _loadLatestScore();
  }

  String _stressMessage = "Hi there";
  String _stressImage = "assets/gifs/animation_1_1_cat2_agadjbgaaq1fyfa.gif";

  void _logout() async {
    await FirebaseAuth.instance.signOut(); // Sign out from Firebase

    // Navigate to login screen and remove HomeScreen from stack
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screenLogin()),
      (route) => false,
    );
  }

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
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'latestScore': finalScore, 'testedTime': DateTime.now()});
      await _loadLatestScore();

      _getStressLevel(finalScore);
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Image.asset(
                      'assets/logo/Stress_Buster__3_-removebg-preview.png',
                      scale: 2,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                if (_stressImage.isNotEmpty) ...[
                  Row(
                    children: [
                      Image.asset(
                        _stressImage,
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          Text(
                            _stressMessage,
                            style: GoogleFonts.spaceGrotesk(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.025,
                              color: Color.fromARGB(255, 253, 186, 226),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            lastTested != null
                                ? "Last tested:\n${lastTested!.day}/${lastTested!.month}/${lastTested!.year}  "
                                      "\n${lastTested!.hour.toString().padLeft(2, '0')}:"
                                      "${lastTested!.minute.toString().padLeft(2, '0')}"
                                : "Not Tested Yet",
                            style: GoogleFonts.spaceGrotesk(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.018,
                              color: Colors.white70,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Container(
                  width: MediaQuery.of(context).size.width * .9,
                  height: MediaQuery.of(context).size.width * .15,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
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
                        color: const Color.fromARGB(255, 162, 240, 244),
                      ),
                    ),

                    trailing: Icon(
                      Icons.arrow_right_outlined,
                      size: MediaQuery.of(context).size.width * .09,
                      color: Color.fromARGB(255, 253, 186, 226),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '     Fidgets',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: MediaQuery.of(context).size.height * 0.025,
                      color: Color.fromARGB(255, 253, 186, 226),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(width: 15),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ClickButton(),
                            ),
                          );
                        },
                        child: Container(
                          width: 150,
                          height: 200,
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage('assets/logo/clickbutton.png'),
                              fit: BoxFit.cover, // Covers the entire container
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FunnyButton(),
                            ),
                          );
                        },
                        child: Container(
                          width: 150,
                          height: 200,
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage('assets/logo/funnybutton.png'),
                              fit: BoxFit.cover, // Covers the entire container
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OnOffButton(),
                            ),
                          );
                        },
                        child: Container(
                          width: 150,
                          height: 200,
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage('assets/logo/onoffbutton.png'),
                              fit: BoxFit.cover, // Covers the entire container
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 150,
                          height: 200,
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage('assets/logo/lock1.jpg'),
                              fit: BoxFit.cover, // Covers the entire container
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 150,
                          height: 200,
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage('assets/logo/lock2.jpg'),
                              fit: BoxFit.cover, // Covers the entire container
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  width: MediaQuery.of(context).size.width * .5,
                  height: MediaQuery.of(context).size.width * .15,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    onTap: _logout,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: Text(
                      'Logout',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: MediaQuery.of(context).size.height * 0.025,
                        color: const Color.fromARGB(255, 162, 240, 244),
                      ),
                    ),

                    trailing: Icon(
                      Icons.logout,
                      size: MediaQuery.of(context).size.width * .09,
                      color: Color.fromARGB(255, 253, 186, 226),
                    ),
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loadLatestScore() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    if (userDoc.exists) {
      int? score = userDoc.data()?['latestScore'];
      Timestamp? testedTime = userDoc.data()?['testedTime'];

      if (score != null) _getStressLevel(score);

      if (testedTime != null) {
        lastTested = testedTime.toDate(); // Store in state variable
      }

      setState(() {}); // 🔥 Refresh UI after loading
    }
  }
}
