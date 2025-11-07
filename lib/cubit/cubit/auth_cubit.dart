import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:recipe_book_app/data/user_model.dart';
import 'package:recipe_book_app/services/firestore_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  UserModel userModel = UserModel(
    uid: '',
    name: '',
    email: '',
    fav: [],
    userProfile: "",
  );
  signUp(String email, String password, String name) async {
    try {
      emit(AuthLoading());
      UserCredential credential = await Services.signUp(email, password, name);
      FirebaseFirestore firestoreService = FirebaseFirestore.instance;
      var snapshot = await firestoreService
          .collection("users")
          .doc(credential.user!.uid)
          .get();
      if (!snapshot.exists) throw Exception("User data not found.");
      Map<String, dynamic>? json = snapshot.data();
      userModel = UserModel.fromJson(json!);
      setSharedPreferences(credential.user!.uid);
      emit(SignIn(user: userModel));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  signIn(String email, String password) async {
    try {
      emit(AuthLoading());
      UserCredential credential = await Services.signIn(email, password);
      FirebaseFirestore firestoreService = FirebaseFirestore.instance;
      var snapshot = await firestoreService
          .collection("users")
          .doc(credential.user!.uid)
          .get();
      if (!snapshot.exists) throw Exception("User data not found.");
      Map<String, dynamic>? json = snapshot.data();
      userModel = UserModel.fromJson(json!);
      setSharedPreferences(credential.user!.uid);
      emit(SignIn(user: userModel));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  logout() async {
    try {
      await Services.signout();
      removeSharedPreferences();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  update({
    String? email,
    String? password,
    String? name,
    List<String>? fav,
    String? userProfile,
  }) async {
    if (name != null) userModel.name = name;
    if (email != null) userModel.email = email;
    if (fav != null) userModel.fav = fav;
    if (userProfile != null) userModel.userProfile = userProfile;

    Map<String, dynamic> updates = userModel.toJson();

    await Services.editUserInfo(
      name: updates['name'],
      email: updates['email'],
      password: updates['password'],
      fav: updates['fav'],
      userProfile: updates['userProfile'],
    );
    emit(UserUpdated(user: userModel));
  }

  Future<void> toggleFavorite(int recipeId) async {
    final idStr = recipeId.toString();
    if (userModel.fav.contains(idStr)) {
      userModel.fav.remove(idStr);
    } else {
      userModel.fav.add(idStr);
    }
    emit(UserUpdated(user: userModel));

    await update(fav: userModel.fav);
  }

  Future<void> setSharedPreferences(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("uid", uid);
  }

  Future<String?> getSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("uid");
  }

  Future<void> removeSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("uid");
  }

  Future<void> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString("uid");
    if (uid != null && uid.isNotEmpty) {
      emit(AuthLoading());
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      var snapshot = await firestore.collection("users").doc(uid).get();
      if (snapshot.exists) {
        userModel = UserModel.fromJson(snapshot.data()!);

        emit(SignIn(user: userModel));
      }
    }
  }
}
