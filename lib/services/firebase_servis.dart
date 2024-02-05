// ignore_for_file: avoid_print, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sosyal_app_munevver/constant/model/user.dart';
import 'package:sosyal_app_munevver/services/base.dart';

class FirebaseServis implements BaseAuth {
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<UserModel?> signwithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    var deneme = await FirebaseAuth.instance.signInWithCredential(credential);
    var gelenuser = UserModel(
      userID: deneme.user!.uid.toString(),
      userMail: deneme.user!.email.toString(),
    );
    await addUser(gelenuser);
    return gelenuser;
  }

  @override
  Future<UserModel?> currentUser() async {
    try {
      var user = auth.currentUser;
      if (user != null) {
        var newUser = UserModel(
          userID: user.uid.toString(),
          userMail: user.email.toString(),
        );
        return newUser;
      } else {
        return null;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
    return null;
  }

  @override
  Future<bool> signOut() async {
    try {
      await auth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  UserModel userConvert(User user) {
    return UserModel(
        userID: user.uid.toString(), userMail: user.email.toString());
  }

  @override
  Stream<UserModel> get userCahageState =>
      auth.authStateChanges().map((event) => userConvert(event!));

  Future addUser(UserModel user) async {
    try {
      await db.collection('user').doc(user.userID).set(user.toMap());
    } catch (e) {
      print('Olmadı Hata iştye bu----------- $e');
    }
  }
}
