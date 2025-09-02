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
  final UserCredential userCredential = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: s.useremail, password: s.userpassword);
  if (userCredential != null) {
    currentUserId = userCredential.user!.uid;
    return Future.value(true);
  } else {
    return Future.value(false);
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
