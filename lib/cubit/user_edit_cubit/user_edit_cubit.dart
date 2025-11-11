import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:recipe_book_app/cubit/auth_cubit/auth_cubit.dart';
import 'package:recipe_book_app/data/recent_recipes_sqlite_db.dart';
import 'package:recipe_book_app/data/user_model.dart';
import 'package:recipe_book_app/services/firestore_service.dart';

part 'user_edit_state.dart';

class UserEditCubit extends Cubit<UserEditState> {
  final AuthCubit authCubit;

  UserEditCubit(this.authCubit) : super(UserEditInitial());

  Future<void> updateUser({
    String? email,
    String? name,
    String? userProfile,
  }) async {
    final userModel = authCubit.userModel;
    final updates = <String, dynamic>{};

    if (name != null) updates['name'] = name;
    if (email != null) updates['email'] = email;
    if (userProfile != null) updates['userProfile'] = userProfile;

    if (updates.isNotEmpty) {
      final updatedUser = userModel.copyWith(
        name: name ?? userModel.name,
        email: email ?? userModel.email,
        userProfile: userProfile ?? userModel.userProfile,
      );

      await Services.editUserInfo(updates);
      authCubit.updateUser(updatedUser);
      emit(UserEditInitial());
    }
  }

  Future<void> toggleFav(String recipeId) async {
    final userModel = authCubit.userModel;
    final favList = List<String>.from(userModel.fav);

    if (favList.contains(recipeId)) {
      favList.remove(recipeId);
    } else {
      favList.add(recipeId);
    }

    final updatedUser = userModel.copyWith(fav: favList);
    await Services.editUserInfo({'fav': favList});
    authCubit.updateUser(updatedUser);
    emit(UserEditInitial());
  }

 

  Future<List<String>> getRecentRecepies() async {
    List<String> recentRecipes = await RecentRecipesSqliteDb.getQueries(
      authCubit.userModel.uid,
    );
    return recentRecipes;
  }

  Future<void> insert(String modelId) async {
    await RecentRecipesSqliteDb.insert(modelId, authCubit.userModel.uid);
    emit(UserEditInitial());

  }

  Future<bool> recentRecipeIsEmpty() async {
    if (await RecentRecipesSqliteDb.isEmpty(authCubit.userModel.uid)) {
      return true;
    }
    return false;
  }
}
