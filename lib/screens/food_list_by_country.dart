import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_book_app/cubit/load_recipes_cubit/cubit/load_recipes_cubit.dart';
import 'package:recipe_book_app/widgets/meal_card_widget.dart';

class FoodListByCountry extends StatelessWidget {
  const FoodListByCountry({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<LoadRecipesCubit, LoadRecipesState>(
              builder: (context, state) {
                List foodList = context
                    .read<LoadRecipesCubit>()
                    .foodByCountryList;
      
                return GridView.builder(
                  shrinkWrap: true,
                  itemCount: foodList.length,
padding: EdgeInsets.symmetric(horizontal: 20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 13,
                    crossAxisSpacing: 13,
                    childAspectRatio: 165 / 140,
                  ),
                  itemBuilder: (context, index) {
                    return MealCardWidget(model: foodList[index]);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
