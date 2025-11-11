import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_book_app/cubit/user_edit_cubit/user_edit_cubit.dart';
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
          ViewAllwidget(title: "All Recipes"),
          SizedBox(height: 14),
          BlocBuilder<LoadRecipesCubit, LoadRecipesState>(
            builder: (context, state) {
              if (state is LoadedRecipesState) {
                return SizedBox(
                  height: 140,
                  child: RecipesList(
                    recipesList: state.allRecipes,
                    listLength: 20,
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              }
            },
          ),

          SizedBox(height: 20),
          ViewAllwidget(title: "Favorite Recipes"),
          SizedBox(height: 14),
          SizedBox(
            height: 140,
            child: BlocBuilder<LoadRecipesCubit, LoadRecipesState>(
              builder: (context, state) {
                if (state is LoadedRecipesState) {
                  return BlocBuilder<UserEditCubit, UserEditState>(
                    builder: (context, state) {
                      if (context.read<UserEditCubit>().authCubit.userModel.fav.isEmpty) {
                        return Center(
                          child: Text(
                            "There are no favorites yet",
                            style: Fonts.primaryColor14,
                          ),
                        );
                      } else {
                        var recipesList = context
                            .read<LoadRecipesCubit>()
                            .allRecipes
                            .where(
                              (e) => context
                                  .read<UserEditCubit>().authCubit
                                  .userModel
                                  .fav
                                  .contains(e.id.toString()),
                            )
                            .toList();
                        return SizedBox(
                          height: 140,
                          child: RecipesList(
                            recipesList: recipesList,
                            listLength: recipesList.length,
                          ),
                        );
                      }
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
