import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_book_app/cubit/check_box_cubit.dart';
import 'package:recipe_book_app/data/models/recipe_model.dart';
import 'package:recipe_book_app/theme/fonts.dart';
import 'package:recipe_book_app/widgets/cheack_list.dart';

class Tab1 extends StatelessWidget {
  const Tab1({super.key, required this.recipe});

  final RecipeModel recipe;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text("Ingredients", style: Fonts.darkGreen20),
            Text(
              " (${recipe.ingredients.length})",
              style: Fonts.darkGreen20.copyWith(color: Colors.red),
            ),
            Spacer(),
            Text(
              " ${recipe.servings} Servings",
              style: Fonts.mealNotes.copyWith(
                fontSize: 15,
                color: Color(0xff637663),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        CheackList(recipe: recipe),
        
      ],
    );
  }
}
