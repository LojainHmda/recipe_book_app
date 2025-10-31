import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_book_app/data/user_model.dart';

class Services {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUser(UserModel user) async {
    await firestore.collection('users').doc(user.uid).set(user.toJson());
  }
}
