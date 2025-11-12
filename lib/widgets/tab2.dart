import 'package:flutter/material.dart';
import 'package:recipe_book_app/data/models/recipe_model.dart';
import 'package:recipe_book_app/theme/colors.dart';
import 'package:recipe_book_app/theme/fonts.dart';

class Tap2 extends StatelessWidget {
  const Tap2({super.key, required this.recipe});

  final RecipeModel recipe;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: recipe.instructions.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: AppColors.primaryColor,
                    child: Text("${index + 1}", style: Fonts.white16),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      recipe.instructions[index],
                      style: Fonts.darkGreen16w,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}
