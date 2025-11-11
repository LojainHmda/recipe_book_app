import 'package:flutter/material.dart';
import 'package:recipe_book_app/theme/colors.dart';
import 'package:recipe_book_app/theme/fonts.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final double width;
  final double height;
  final VoidCallback? onPressed;
  final bool isActive;
  const PrimaryButton({
    super.key,
    required this.label,
    required this.width,
    this.height = 52,
    this.onPressed,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        
        onPressed: onPressed ?? () {},
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 5),
          backgroundColor: isActive
              ? AppColors.primaryColor
              : Colors.transparent,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Text(label, style: Fonts.white16),
      ),
    );
  }
}
