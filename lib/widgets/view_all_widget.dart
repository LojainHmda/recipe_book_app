
import 'package:flutter/material.dart';
import 'package:recipe_book_app/theme/fonts.dart';

class ViewAllwidget extends StatelessWidget {
   const ViewAllwidget({
    super.key, required this.title,
  });
final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Fonts.h2),
        Text("View All", style: Fonts.primaryColor14),
      ],
    );
  }
}