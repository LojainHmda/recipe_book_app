import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_book_app/cubit/user_edit_cubit/user_edit_cubit.dart';
import 'package:recipe_book_app/data/recent_recipes_sqlite_db.dart';
import 'package:recipe_book_app/data/recipe_model.dart';
import 'package:recipe_book_app/screens/meal_screen.dart';
import 'package:recipe_book_app/theme/fonts.dart';

class MealCardWidget extends StatelessWidget {
  final RecipeModel model;
  const MealCardWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MealScreen(recipe: model)),
        );
        context.read<UserEditCubit>().insert(model.id.toString());
      },
      child: Container(
        height: 140,
        width: 161,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                model.mealImage,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black],
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 9,
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                child: InkWell(
                  onTap: () => context.read<UserEditCubit>().toggleFav(
                    model.id.toString(),
                  ),
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    height: 26,
                    width: 26,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: BlocBuilder<UserEditCubit, UserEditState>(
                      builder: (context, state) {
                        final isFav = context
                            .read<UserEditCubit>()
                            .authCubit
                            .userModel
                            .fav
                            .contains(model.id.toString());
                        return Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.red : Colors.white,
                          size: 16.5,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 9,
              bottom: 8,
              right: 9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.countryName.toUpperCase(), style: Fonts.mealNotes),
                  Text(model.mealTitle, style: Fonts.F13),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(model.mealType[0], style: Fonts.mealNotes),
                      const SizedBox(width: 6),
                      Text("|", style: Fonts.mealNotes),
                      const SizedBox(width: 6),
                      Text("${model.cookingTime}m", style: Fonts.mealNotes),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rate_rounded,
                            color: Color(0xffFFA909),
                            size: 10.84,
                          ),
                          Text(
                            "${model.rating}",
                            style: GoogleFonts.montserrat(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xffFFA909),
                            ),
                          ),
                        ],
                      ),
                    ],
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
