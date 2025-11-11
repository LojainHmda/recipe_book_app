import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_book_app/data/auth_shared_preferences.dart';
import 'package:recipe_book_app/data/user_model.dart';
import 'package:recipe_book_app/services/firestore_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(Logout());
  FirebaseFirestore firestoreService = FirebaseFirestore.instance;

  UserModel userModel = UserModel(
    uid: '',
    name: '',
    email: '',
    fav: [],
    userProfile: "",
  );

  void goToSignUp() => emit(ShowSignUpScreen());
  void goToSignIn() => emit(ShowSignInScreen());

  signUp(String email, String password, String name) async {
    try {
      emit(AuthLoading());
      UserCredential credential = await Services.signUp(email, password, name);
      await data(credential);
      emit(SignUpSucsess(user: userModel));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  signIn(String email, String password) async {
    try {
      emit(AuthLoading());
      UserCredential credential = await Services.signIn(email, password);
      await data(credential);
      emit(SignInSucsess(user: userModel));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  data(UserCredential credential) async {
    var snapshot = await firestoreService
        .collection("users")
        .doc(credential.user!.uid)
        .get();
    if (!snapshot.exists) throw Exception("User data not found.");
    Map<String, dynamic>? json = snapshot.data();
    userModel = UserModel.fromJson(json!);
    userModel.uid = credential.user!.uid;
    AuthSharedPreferences.setSharedPreferences(credential.user!.uid);
  }

  logout() async {
    try {
      await Services.signout();
      AuthSharedPreferences.removeSharedPreferences();
      emit(Logout());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> autoLogin() async {
    emit(AuthLoading());
    var uid = await AuthSharedPreferences.getSharedPreferences();
    if (uid != null && uid.isNotEmpty) {
      var snapshot = await firestoreService.collection("users").doc(uid).get();
      if (snapshot.exists) {
        userModel = UserModel.fromJson(snapshot.data()!);
        userModel.uid = uid;
        emit(SignInSucsess(user: userModel));
      }
    }
  }

  void updateUser(UserModel updatedUser) {
    userModel = updatedUser;
  }
}
