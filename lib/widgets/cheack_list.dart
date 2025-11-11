
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_book_app/cubit/check_box_cubit.dart' show CheckBoxCubit;
import 'package:recipe_book_app/data/recipe_model.dart';
import 'package:recipe_book_app/theme/colors.dart';
import 'package:recipe_book_app/theme/fonts.dart';

class CheackList extends StatelessWidget {
  const CheackList({super.key, required this.recipe});
  final RecipeModel recipe;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: recipe.ingredients.length,
        itemBuilder: (context, index) {
          return BlocProvider(
            create: (context) => CheckBoxCubit(),
            child: BlocBuilder<CheckBoxCubit, bool>(
              builder: (context, state) {
                return Row(
                  children: [
                    Checkbox(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      activeColor: AppColors.primaryColor,
                      checkColor: Colors.white,
                      side: BorderSide(color: AppColors.primaryColor, width: 2),
                      value: state,
                      onChanged: (_) {
                        context.read<CheckBoxCubit>().toggle();
                      },
                    ),
                    SizedBox(width: 5),
                    Text(
                      recipe.ingredients[index],
                      style: Fonts.darkGreen16w.copyWith(
                        decoration: state ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
