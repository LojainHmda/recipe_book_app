import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_book_app/cubit/change_widget/change_widget_cubit.dart';
import 'package:recipe_book_app/data/recipe_model.dart';
import 'package:recipe_book_app/theme/fonts.dart';
import 'package:recipe_book_app/widgets/buttons/Text_button_tab.dart';
import 'package:recipe_book_app/widgets/cheack_list.dart';

class MealScreen extends StatelessWidget {
  MealScreen({super.key, required this.recipe});
  final RecipeModel recipe;
  late List<Widget> list = [
    NewWidget0(
      overview:
          "crispy fried chicken coated in sweet and spicy sauce. It's accompanied by pickled radishes, sliced scallions, and a side of rice. Cold beer or soft drinks are popular pairings. Enjoy!",
    ),
    NewWidget1(recipe: recipe),
    SizedBox(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangeWidgetCubit(),
      child: SafeArea(
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
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  recipe.mealImage,
                  height: 316,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  child: BlocBuilder<ChangeWidgetCubit, ChangeWidgetState>(
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(recipe.mealTitle, style: Fonts.titlesFont24),
                          SizedBox(height: 20),
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(77, 215, 217, 215),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButtonTab(index: 0, label: "Overview"),
                                TextButtonTab(index: 1, label: "Ingredients"),
                                TextButtonTab(index: 2, label: "Directions"),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          context.read<ChangeWidgetCubit>().mainIndex == 0
                              ? list[0]
                              : context.read<ChangeWidgetCubit>().mainIndex == 1
                              ? list[1]
                              : list[2],
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NewWidget0 extends StatelessWidget {
  const NewWidget0({super.key, required this.overview});
  final String overview;
  @override
  Widget build(BuildContext context) {
    return Text(overview, style: Fonts.darkGreen16w);
  }
}

class NewWidget1 extends StatelessWidget {
  const NewWidget1({super.key, required this.recipe});

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
