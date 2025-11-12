import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:recipe_book_app/cubit/change_widget/change_widget_cubit.dart';
import 'package:recipe_book_app/cubit/check_box_cubit.dart';
import 'package:recipe_book_app/data/models/recipe_model.dart';
import 'package:recipe_book_app/theme/colors.dart';
import 'package:recipe_book_app/theme/fonts.dart';
import 'package:recipe_book_app/widgets/tab2.dart';
import 'package:recipe_book_app/widgets/buttons/Text_button_tab.dart';
import 'package:recipe_book_app/widgets/cheack_list.dart';
import 'package:recipe_book_app/widgets/tab1.dart';

class MealScreen extends StatelessWidget {
  MealScreen({super.key, required this.recipe});
  final RecipeModel recipe;
  late final List<Widget> list = [
    Tab0(
      overview:
          "crispy fried chicken coated in sweet and spicy sauce. It's accompanied by pickled radishes, sliced scallions, and a side of rice. Cold beer or soft drinks are popular pairings. Enjoy!",
    ),
    Tab1(recipe: recipe),
    Tap2(recipe: recipe),
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
                          SizedBox(height: 20),

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
                          list[context.read<ChangeWidgetCubit>().mainIndex],
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

class Tab0 extends StatelessWidget {
  const Tab0({super.key, required this.overview});
  final String overview;
  @override
  Widget build(BuildContext context) {
    return Text(overview, style: Fonts.darkGreen16w);
  }
}
