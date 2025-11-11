import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_book_app/cubit/auth_cubit/auth_cubit.dart';
import 'package:recipe_book_app/cubit/load_recipes_cubit/cubit/load_recipes_cubit.dart';
import 'package:recipe_book_app/cubit/user_edit_cubit/user_edit_cubit.dart';
import 'package:recipe_book_app/theme/colors.dart';
import 'package:recipe_book_app/widgets/buttons/button_primary.dart';
import 'package:recipe_book_app/widgets/recipes_list_widget.dart';
import 'package:recipe_book_app/widgets/view_all_widget.dart';
import '../theme/fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Profile", style: Fonts.titlesFont24),
          SizedBox(height: 20),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(100),
                child: Image.asset(
                  "assets/weekly_pick.png",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.read<UserEditCubit>().authCubit.userModel.name,
                    style: Fonts.titlesFont24.copyWith(fontSize: 20),
                  ),
                  Text(
                    context.read<UserEditCubit>().authCubit.userModel.email,
                    style: Fonts.h6.copyWith(color: AppColors.grey),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: AppColors.grey),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Edit Profile",
                      style: Fonts.F13.copyWith(
                        color: AppColors.darkGreen1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 50),
          ViewAllwidget(title: "Recent Recipes"),
          SizedBox(height: 14),

          BlocBuilder<UserEditCubit, UserEditState>(
            builder: (context, state) {
              return FutureBuilder<List<dynamic>>(
                future: Future.wait([
                  context.read<UserEditCubit>().recentRecipeIsEmpty(),
                  context.read<UserEditCubit>().getRecentRecepies(),
                ]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("An error occurred: ${snapshot.error}"),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        "No data available",
                        style: Fonts.primaryColor14,
                      ),
                    );
                  }
                  bool isEmpty = snapshot.data![0];
                  List<String> recipes = snapshot.data![1];
                  if (isEmpty) {
                    return SizedBox(
                      height: 140,
                      child: Center(
                        child: Text(
                          "No data available",
                          style: Fonts.primaryColor14,
                        ),
                      ),
                    );
                  } else {
              var list = context
    .read<LoadRecipesCubit>()
    .allRecipes
    .where((e) => recipes.contains(e.id.toString()))
    .toList()
  ..sort((a, b) => recipes.indexOf(a.id.toString()) - recipes.indexOf(b.id.toString()));


                    return SizedBox(
                      height: 140,
                      child: RecipesList(
                        recipesList: list,
                        listLength: list.length,
                      ),
                    );
                  }
                },
              );
            },
          ),

          SizedBox(height: 50),
          Center(
            child: PrimaryButton(
              label: "Logout",
              width: 150,
              onPressed: () async {
                await context.read<AuthCubit>().logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
