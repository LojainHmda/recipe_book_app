
import 'package:flutter/material.dart';
import 'package:recipe_book_app/theme/colors.dart';

class SocialMediaWidget extends StatelessWidget {
   const SocialMediaWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: AppColors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 24,
            ),
            child: Image.asset("assets/Icon.png"),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: AppColors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              Icons.facebook,
              color: Color(0xff1877F2),
              size: 24,
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: AppColors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset("assets/twitter.png"),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: AppColors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(Icons.apple, size: 24),
          ),
        ),
      ],
    );
  }
}
