import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http show get;
import 'package:recipe_book_app/data/recipe_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'load_recipes_state.dart';

class LoadRecipesCubit extends Cubit<LoadRecipesState> {
  LoadRecipesCubit() : super(LoadRecipesInitial());
  List<RecipeModel> recentRecipes = [];
  final Map<String, String> countryAndImage = {};
  List<RecipeModel> foodByCountryList = [];

  loading() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/recipes'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List recipes = data['recipes'];

      recentRecipes = recipes
          .map((json) => RecipeModel.fromJson(json))
          .toList();
    }

    emit(LoadedRecipesState(recentRecipes: recentRecipes));
  }

  void toggleFavorite(int recipeId) {
    final index = recentRecipes.indexWhere((r) => r.id == recipeId);
    if (index != -1) {
      recentRecipes[index].isFav = !recentRecipes[index].isFav;
      emit(LoadedRecipesState(recentRecipes: List.from(recentRecipes)));
    }
    setsharedPreferences();
  }

  List<RecipeModel> get favoriteRecipes {
    return recentRecipes.where((e) => e.isFav).toList();
  }

  setsharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favList = favoriteRecipes
        .map((r) => jsonEncode(r.toJson()))
        .toList();
    await prefs.setStringList('favorites', favList);
  }

  getSharedPreferences() async {
    List<RecipeModel> favList;
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('favorites') != null) {
      favList = (prefs.getStringList(
        'favorites',
      ))!.map((s) => RecipeModel.fromJson(jsonDecode(s))).toList();
      for (var i in favList) {
        final index = recentRecipes.indexWhere((r) => r.id == i.id);
        recentRecipes[index].isFav = true;
      }
      emit(LoadedRecipesState(recentRecipes: List.from(recentRecipes)));
    }
  }

  Future cuntryFood() async {
    final countries = recentRecipes.map((i) => i.countryName).toSet();
    for (var country in countries) {
      final recipe = recentRecipes.firstWhere((i) => i.countryName == country);

      countryAndImage[country] = recipe.mealImage;
    }
  }

  Future foodByCountry(String country) async {
    foodByCountryList = await recentRecipes
        .where((i) => i.countryName == country)
        .toList();
    return foodByCountryList;
  }
}
