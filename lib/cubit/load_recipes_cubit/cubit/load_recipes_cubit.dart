import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http show get;
import 'package:path/path.dart';
import 'package:recipe_book_app/data/sqlite/category_sqlite_db.dart';
import 'package:recipe_book_app/data/sqlite/recent_recipes_sqlite_db.dart';
import 'package:recipe_book_app/data/models/recipe_model.dart';
part 'load_recipes_state.dart';

class LoadRecipesCubit extends Cubit<LoadRecipesState> {
  LoadRecipesCubit() : super(LoadingRecipesState());
  List<RecipeModel> allRecipes = [];
  List<RecipeModel> foodByCountryList = [];

  loading() async {
    emit(LoadingRecipesState());
    final response = await http.get(Uri.parse('https://dummyjson.com/recipes'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List recipes = data['recipes'];
      allRecipes = recipes.map((json) => RecipeModel.fromJson(json)).toList();
    }
    emit(LoadedRecipesState(allRecipes: allRecipes));
  }

  Future foodByCountry(String country) async {
    foodByCountryList = allRecipes
        .where((i) => i.countryName == country)
        .toList();
    return foodByCountryList;
  }

  Future<Map<String, String>> getCountryandImg() async {
    if (await CategorySqliteDb.isEmpty()) {
      await loading();
      final countries = allRecipes.map((i) => i.countryName).toSet();
      for (var country in countries) {
        final recipe = allRecipes.firstWhere((i) => i.countryName == country);
        await CategorySqliteDb.insert(country, recipe.mealImage);
      }
    }
    return await CategorySqliteDb.getQueries();
  }



}
