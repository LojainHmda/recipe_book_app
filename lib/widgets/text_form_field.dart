import 'package:flutter/material.dart';
import 'package:recipe_book_app/theme/colors.dart';
import 'package:recipe_book_app/theme/fonts.dart';

class TextFomfieldWidget extends StatelessWidget {
  TextFomfieldWidget({
    super.key,
    required this.controller,
    required this.icon,
    required this.hintText,
    this.icon2,
  });
  final Icon icon;
  final String hintText;
  Icon? icon2;
final TextEditingController controller; 
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Fonts.darkGreen16,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Fonts.darkGreen15,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 24,left: 10),
          child: icon2 ?? SizedBox(),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 24, right: 10),
          child: icon,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(color: Colors.redAccent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(color: AppColors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(color: AppColors.grey),
        ),
        contentPadding: EdgeInsets.fromLTRB(10, 14, 24, 14),
      ),
    );
  }
}
