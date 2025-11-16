import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nostressr/core/core.dart';
import 'package:nostressr/model/user_model.dart';

Future<bool> addUser(Usermodel s) async {
  try {
    final UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: s.useremail,
          password: s.userpassword,
        );
    // ignore: unnecessary_null_comparison
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .set({'user_name': s.username, 'user_email': s.useremail});
    return Future.value(true);
  } catch (e) {
    return false;
  }
}

Future<bool> checklogin(Usermodel s) async {
  try {
    final UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: s.useremail,
          password: s.userpassword,
        );

    currentUserId = userCredential.user!.uid;
    return true; // successful login
  } on FirebaseAuthException catch (e) {
    print("Login failed: ${e.code} - ${e.message}");
    return false; // login failed (wrong password, user not found, etc.)
  } catch (e) {
    print("Unexpected error: $e");
    return false; // any other error
  }
}

Future<Usermodel> loaduser(String userID) async {
  final firebaseInstance = await FirebaseFirestore.instance
      .collection('users')
      .doc(userID)
      .get();
  final userData = firebaseInstance.data();
  Usermodel u = Usermodel(
    '',
    userData!['user_name'],
    userData['user_email'],
    userData['user_password'],
  );
  return Future.value(u);
}
