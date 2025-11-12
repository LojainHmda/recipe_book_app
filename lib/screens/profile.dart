import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_book_app/cubit/auth_cubit/auth_cubit.dart';
import 'package:recipe_book_app/cubit/cubit/recent_recipes_cubit.dart';
import 'package:recipe_book_app/cubit/load_recipes_cubit/cubit/load_recipes_cubit.dart';
import 'package:recipe_book_app/cubit/user_edit_cubit/user_edit_cubit.dart';
import 'package:recipe_book_app/theme/colors.dart';
import 'package:recipe_book_app/widgets/buttons/button_primary.dart';
import 'package:recipe_book_app/widgets/recipes_list_widget.dart';
import 'package:recipe_book_app/widgets/view_all_widget.dart';
import 'package:image_picker/image_picker.dart';
import '../theme/fonts.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

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
              Stack(
                alignment: AlignmentGeometry.topRight,
                children: [
                  Container(
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(100),
                      child:
                          context
                                      .read<UserEditCubit>()
                                      .authCubit
                                      .userModel
                                      .userProfile !=
                                  null &&
                              context
                                  .read<UserEditCubit>()
                                  .authCubit
                                  .userModel
                                  .userProfile!
                                  .isNotEmpty
                          ? Image.network(
                              context
                                  .read<UserEditCubit>()
                                  .authCubit
                                  .userModel
                                  .userProfile!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              "assets/user.png",
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final picker = ImagePicker();
                      final XFile? image = await picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (image != null) {
                        print('Path: ${image.path}');
                      } else {
                        print('No image selected.');
                      }
                    },
                    icon: Icon(
                      Icons.add_circle,
                      color: AppColors.primaryColor,
                      size: 30,
                    ),
                  ),
                ],
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
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          final nameController = TextEditingController(
                            text: context
                                .read<UserEditCubit>()
                                .authCubit
                                .userModel
                                .name,
                          );
                          final emailController = TextEditingController(
                            text: context
                                .read<UserEditCubit>()
                                .authCubit
                                .userModel
                                .email,
                          );

                          return AlertDialog(
                            title: Text("Edit Profile"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    labelText: "Name",
                                  ),
                                ),
                                TextField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    labelText: "Email",
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("Cancel"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<UserEditCubit>().updateUser(
                                    name: nameController.text,
                                    email: emailController.text,
                                  );
                                  Navigator.pop(context);
                                },
                                child: Text("Save"),
                              ),
                            ],
                          );
                        },
                      );
                    },
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
          BlocBuilder<RecentRecipesCubit, RecentRecipesState>(
            builder: (context, state) {
              if (state is RecentRecipesLoading) {
                context.read<RecentRecipesCubit>().getRecentRecepies();
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              }

              if (state is RecentRecipesInitial) {
                context.read<RecentRecipesCubit>().recentRecipeIsEmpty();
                return Center(
                  child: Text("No data available", style: Fonts.primaryColor14),
                );
              }

              if (state is RecentRecipesLoaded) {
                final recentCubit = context.read<RecentRecipesCubit>();
                final loadCubit = context.read<LoadRecipesCubit>();

                var list =
                    loadCubit.allRecipes
                        .where(
                          (e) => recentCubit.recentRecipes.contains(
                            e.id.toString(),
                          ),
                        )
                        .toList()
                      ..sort(
                        (a, b) =>
                            recentCubit.recentRecipes.indexOf(a.id.toString()) -
                            recentCubit.recentRecipes.indexOf(b.id.toString()),
                      );

                return SizedBox(
                  height: 140,
                  child: RecipesList(
                    recipesList: list,
                    listLength: list.length,
                  ),
                );
              }

              return SizedBox.shrink();
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
