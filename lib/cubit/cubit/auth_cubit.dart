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

  Future<void> signUp(String email, String password, String name) async {
    emit(AuthLoading());
    try {
      UserCredential credential = await Services.signUp(email, password, name);
      FirebaseFirestore firestoreService = FirebaseFirestore.instance;
      var snapshot = await firestoreService
          .collection("users")
          .doc(credential.user!.uid)
          .get();
      Map<String, dynamic>? json = snapshot.data();
      userModel = UserModel.fromJson(json!);
      emit(SignIn(user: userModel));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  logout() async {
    await Services.signout();
    emit(AuthInitial());
  }

  signIn(String email, String password) async {
    UserCredential credential = await Services.signIn(email, password);
    FirebaseFirestore firestoreService = FirebaseFirestore.instance;
    var snapshot = await firestoreService
        .collection("users")
        .doc(credential.user!.uid)
        .get();
    Map<String, dynamic>? json = snapshot.data();
    userModel = UserModel.fromJson(json!);
    emit(SignIn(user: userModel));
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

  // void toggleFavorite(int recipeId) {

  //   setsharedPreferences();
  // }

  // setsharedPreferences() async {
  //   final prefs = await SharedPreferences.getInstance();
  //  UserModel user = favoriteRecipes
  //       .map((r) => jsonEncode(r.toJson()))
  //       .toList();

  //   await prefs.setStringList('user', favList);
  // }

  // getSharedPreferences() async {
  //   List<RecipeModel> favList;
  //   final prefs = await SharedPreferences.getInstance();
  //   if (prefs.getStringList('favorites') != null) {
  //     favList = (prefs.getStringList(
  //       'favorites',
  //     ))!.map((s) => RecipeModel.fromJson(jsonDecode(s))).toList();
  //     for (var i in favList) {
  //       final index = recentRecipes.indexWhere((r) => r.id == i.id);
  //       recentRecipes[index].isFav = true;
  //     }
  //     emit(LoadedRecipesState(recentRecipes: List.from(recentRecipes)));
  //   }
  // }
}
