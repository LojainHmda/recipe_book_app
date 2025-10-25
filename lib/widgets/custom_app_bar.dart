
import 'package:flutter/material.dart';
import 'package:recipe_book_app/theme/colors.dart';
import 'package:recipe_book_app/theme/fonts.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Explor Recipes",
          style: Fonts.h1,
        ),
    
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.grey),
          ),
    
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.add, color:AppColors.primaryColor),
          ),
        ),
      ],
    );
  }
}
