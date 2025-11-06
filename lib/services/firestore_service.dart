import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Services {
  static Future<UserCredential> signUp(
    String email,
    String password,
    String name, {
    String userProfile ="",
    List<String> fav=const[],
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestoreService = FirebaseFirestore.instance;
    var credentials = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    var uid = credentials.user!.uid;
    await firestoreService.collection("users").doc(uid).set({
      "name": name,
      "email": email,
      "userProfile": userProfile,
      "fav": fav ,
    });
    return credentials;
  }

  static Future<UserCredential> signIn(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    var credentials = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credentials;
  }

  static Future<void> editUserInfo({
    String? name,
    String? password,

    String? email,
    String? userProfile,
    List<String>? fav,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    final uid = auth.currentUser?.uid;
    if (uid == null) return;

    final updates = <String, dynamic>{};

    if (name != null) updates['name'] = name;
    if (email != null) await auth.currentUser!.verifyBeforeUpdateEmail(email);

    if (password != null) await auth.currentUser!.updatePassword(password);
    if (userProfile != null) updates['userProfile'] = userProfile;
    if (fav != null) updates['fav'] = fav;

    await firestore.collection("users").doc(uid).update(updates);
  }

  static Future<void> signout() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
  }
}
