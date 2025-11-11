import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Services {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<UserCredential> signUp(
    String email,
    String password,
    String name, {
    String userProfile = "",
    List<String> fav = const [],
  }) async {
    var credentials = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    var uid = credentials.user!.uid;
    await firestore.collection("users").doc(uid).set({
      "name": name,
      "email": email,
      "userProfile": userProfile,
      "fav": fav,
    });
    return credentials;
  }

  static Future<UserCredential> signIn(String email, String password) async {
    var credentials = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credentials;
  }

  static Future<void> editUserInfo(Map<String, dynamic> updates) async {
    final uid = auth.currentUser?.uid;
    if (uid == null) return;

    await firestore.collection("users").doc(uid).update(updates);
  }

  static Future<void> signout() async {
    await auth.signOut();
  }
}
