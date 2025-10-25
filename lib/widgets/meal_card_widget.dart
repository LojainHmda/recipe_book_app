import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:recipe_book_app/cubit/is_fav_cubit.dart';
import 'package:recipe_book_app/cubit/is_fav_states.dart';
import 'package:recipe_book_app/data/recipe_model.dart';
import 'package:recipe_book_app/theme/fonts.dart';

class MealCardWidget extends StatelessWidget {
  const MealCardWidget({super.key, required this.model});
  final RecipeModel model;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.bottomLeft,
      children: [
        Image.network(
          model.mealImage,
          height: 140,
          width: 161,
          fit: BoxFit.fill,
        ),
        Container(
          height: 140,
          width: 161,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),

            gradient: LinearGradient(
              begin: AlignmentGeometry.topCenter,
              end: AlignmentGeometry.bottomCenter,
              colors: [Colors.transparent, Colors.black],
            ),
          ),
        ),
        Positioned(
          top: 8,
          left: 126,
          child: BlocBuilder<IsFavCubit, IsFavStates>(
            builder: (context, state) {
              return InkWell(
                onTap: () {
                  model.isFav = !model.isFav;
                  model.isFav
                      ? context.read<IsFavCubit>().isFav()
                      : context.read<IsFavCubit>().isNotFav();
                },
                child: Container(
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha((0.2 * 255).toInt()),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    model.isFav ? Icons.favorite : Icons.favorite_border,
                    color: model.isFav ? Colors.red : Colors.white,
                    size: 16.5,
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          top: 87,
          left: 9,
          child: Text(model.countryName.toUpperCase(), style: Fonts.mealNotes),
        ),
        Positioned(
          top: 102,
          left: 9,
          child: Text(model.mealTitle, style: Fonts.F13),
        ),
        Positioned(
          top: 119,
          left: 9,
          child: Text(model.mealType[0], style: Fonts.mealNotes),
        ),
        Positioned(
          top: 119,
          left: 42,
          child: Text("|", style: Fonts.mealNotes),
        ),
        Positioned(
          top: 119,
          left: 46,
          child: Text("${model.cookingTime}m", style: Fonts.mealNotes),
        ),
        Positioned(
          top: 119,
          left: 123,
          child: Row(
            children: [
              Icon(
                Icons.star_rate_rounded,
                color: Color(0xffFFA909),
                size: 10.84,
              ),
              Text(
                "${model.rating}",
                style: GoogleFonts.montserrat(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffFFA909),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
