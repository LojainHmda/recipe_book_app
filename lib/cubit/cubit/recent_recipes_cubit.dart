import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:recipe_book_app/cubit/auth_cubit/auth_cubit.dart';
import 'package:recipe_book_app/cubit/user_edit_cubit/user_edit_cubit.dart';
import 'package:recipe_book_app/data/sqlite/recent_recipes_sqlite_db.dart';

part 'recent_recipes_state.dart';

class RecentRecipesCubit extends Cubit<RecentRecipesState> {
  RecentRecipesCubit(this.authCubit) : super(RecentRecipesInitial());
  final AuthCubit authCubit;
  List<String> recentRecipes = [];

  Future recentRecipeIsEmpty() async {
    if (await RecentRecipesSqliteDb.isEmpty(authCubit.userModel.uid)) {
      emit(RecentRecipesInitial());
    } else {
      emit(RecentRecipesLoading());
    }
  }

  Future getRecentRecepies() async {
    recentRecipes = await RecentRecipesSqliteDb.getQueries(
      authCubit.userModel.uid,
    );
    emit(RecentRecipesLoaded());
  }
}
