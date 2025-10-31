import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:recipe_book_app/data/recipe_model.dart';
import 'package:recipe_book_app/theme/fonts.dart';
import 'package:recipe_book_app/widgets/button_primary.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({super.key, required this.recipe});
  final RecipeModel recipe;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Colors.white.withOpacity(0.2),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              recipe.mealImage,
              height: 316,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  SizedBox(height: 20),
                  Text(recipe.mealTitle, style: Fonts.titlesFont24),
                  SizedBox(height: 14),

                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xffF5F6F5),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: PrimaryButton(
                              label: "Overview",
                              height: 40,
                              width: 140,

                              onPressed: () {},
                            ),
                          ),
                          PrimaryButton(
                            label: "Ingredients",
                            height: 40,
                            width: 145,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: PrimaryButton(
                              label: "Directions",
                              height: 40,
                              width: 140,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
