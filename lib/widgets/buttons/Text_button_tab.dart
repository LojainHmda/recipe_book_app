import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_book_app/cubit/change_widget/change_widget_cubit.dart';
import 'package:recipe_book_app/theme/colors.dart';
import 'package:recipe_book_app/theme/fonts.dart';

class TextButtonTab extends StatelessWidget {
  const TextButtonTab({super.key, required this.index, required this.label});
  final int index;
    final String label;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.read<ChangeWidgetCubit>().refresh(index);
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        backgroundColor: context.read<ChangeWidgetCubit>().mainIndex == index
            ? AppColors.primaryColor
            : Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
      child: Text(
        label,
        style: context.read<ChangeWidgetCubit>().mainIndex == index
            ? Fonts.white16
            : Fonts.darkGreen16w,
      ),
    );
  }
}
