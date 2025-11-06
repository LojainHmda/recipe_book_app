import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_book_app/cubit/cubit/auth_cubit.dart';
import 'package:recipe_book_app/cubit/load_recipes_cubit/cubit/load_recipes_cubit.dart';
import 'package:recipe_book_app/theme/colors.dart';
import 'package:recipe_book_app/theme/fonts.dart';
import 'package:recipe_book_app/widgets/discover_widget.dart';
import 'package:recipe_book_app/widgets/recipes_list_widget.dart';
import 'package:recipe_book_app/widgets/view_all_widget.dart'
    show ViewAllwidget;
import 'package:recipe_book_app/widgets/weekly_pick_widget.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Explor Recipes", style: Fonts.titlesFont24),

              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.grey),
                ),

                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.add, color: AppColors.primaryColor),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          WeeklyPickWidget(),
          SizedBox(height: 20),
          DiscoverWidget(),
          SizedBox(height: 20),
          ViewAllwidget(title: "Recent Recipes"),
          SizedBox(height: 14),
          BlocBuilder<LoadRecipesCubit, LoadRecipesState>(
            builder: (context, state) {
              if (state is LoadedRecipesState) {
                return SizedBox(
                  height: 140,
                  child: RecipesList(
                    recipesList: state.recentRecipes,
                    listLength: 20,
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),

          SizedBox(height: 20),
          ViewAllwidget(title: "Favorite Recipes"),
          SizedBox(height: 14),
          SizedBox(
            height: 140,
            child: BlocBuilder<LoadRecipesCubit, LoadRecipesState>(
              builder: (context, recipeState) {
                final favList = context.read<AuthCubit>().userModel.fav;

                if (favList.isEmpty) {
                  return Center(
                    child: Text(
                      "There are no favorites yet",
                      style: Fonts.primaryColor14,
                    ),
                  );
                }

                if (recipeState is LoadedRecipesState) {
                  // هون منعمل BlocBuilder تاني جواته لحتى يسمع لتغييرات المستخدم
                  return BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, authState) {
                      final favRecipes = recipeState.recentRecipes
                          .where((e) => favList.contains(e.id.toString()))
                          .toList();

                      return SizedBox(
                        height: 140,
                        child: RecipesList(
                          recipesList: favRecipes,
                          listLength: favRecipes.length,
                        ),
                      );
                    },
                  );
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
