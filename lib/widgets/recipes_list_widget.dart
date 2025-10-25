import 'package:flutter/material.dart';
import 'package:recipe_book_app/data/recipe_model.dart' show RecipeModel;

import 'meal_card_widget.dart';

class RecipesList extends StatelessWidget {
  const RecipesList({
    super.key,
    required this.recipesList,
    required this.listLength,
  });

  final List<RecipeModel> recipesList;
  final int listLength;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: listLength,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 14.0),
          child: MealCardWidget(model: recipesList[index]),
        );
      },
    );
  }
}
