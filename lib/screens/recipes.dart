import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_book_app/cubit/is_fav_cubit.dart';
import 'package:recipe_book_app/cubit/is_fav_states.dart';
import 'package:recipe_book_app/data/recipe_model.dart';
import 'package:recipe_book_app/widgets/custom_app_bar.dart';
import 'package:recipe_book_app/widgets/discover_widget.dart';
import 'package:recipe_book_app/widgets/recipes_list_widget.dart';
import 'package:recipe_book_app/widgets/view_all_widget.dart'
    show ViewAllwidget;
import 'package:recipe_book_app/widgets/weekly_pick_widget.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  List<RecipeModel> recentRecipes = [];
  List<RecipeModel> favoriteRecipes = [];
  int index = 0;

  @override
  void initState() {
    super.initState();
    fetchRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 19, right: 19, top: 58),
          child: SingleChildScrollView(
            child: BlocProvider<IsFavCubit>(
              create: (BuildContext context) {
                return IsFavCubit();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(),
                  SizedBox(height: 20),
                  WeeklyPickWidget(),
                  SizedBox(height: 20),
                  DiscoverWidget(),
                  SizedBox(height: 20),
                  ViewAllwidget(title: "Recent Recipes"),
                  SizedBox(height: 14),
                  SizedBox(
                    height: 140,
                    child: RecipesList(
                      recipesList: recentRecipes,
                      listLength: 20,
                    ),
                  ),
                  SizedBox(height: 20),
                  ViewAllwidget(title: "Favorite Recipes"),
                  SizedBox(height: 14),
                  SizedBox(
                    height: 140,

                    child: BlocBuilder<IsFavCubit, IsFavStates>(
                      builder: (context, state) {
                        return RecipesList(
                          recipesList: updateFavorites(),
                          listLength: favoriteRecipes.length,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<RecipeModel> updateFavorites() {
    favoriteRecipes = recentRecipes.where((r) => r.isFav).toList();
    return favoriteRecipes;
  }

  Future<void> fetchRecipes() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/recipes'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List recipes = data['recipes'];

      setState(() {
        recentRecipes = recipes
            .map((json) => RecipeModel.fromJson(json))
            .toList();
      });
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}
