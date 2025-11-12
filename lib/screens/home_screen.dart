import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_book_app/cubit/auth_cubit/auth_cubit.dart';
import 'package:recipe_book_app/cubit/check_box_cubit.dart';
import 'package:recipe_book_app/cubit/cubit/recent_recipes_cubit.dart';
import 'package:recipe_book_app/cubit/load_recipes_cubit/cubit/load_recipes_cubit.dart';
import 'package:recipe_book_app/screens/explore.dart';
import 'package:recipe_book_app/screens/profile.dart';
import 'package:recipe_book_app/screens/recipes.dart';
import 'package:recipe_book_app/theme/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  List<Widget> bodies = [
    RecipesScreen(),
    ExploreScreen(),

    BlocProvider(
      create: (context) => RecentRecipesCubit(context.read<AuthCubit>()),
      child: ProfileScreen(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    fun();
  }

  fun() async {
    final cubit = context.read<LoadRecipesCubit>();
    await cubit.loading();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Stack(
          alignment: AlignmentGeometry.topCenter,
          children: [
            SizedBox(
              height: 116,
              child: BottomNavigationBar(
                iconSize: 24,
                selectedItemColor: AppColors.primaryColor,
                currentIndex: index,

                onTap: (value) {
                  setState(() {
                    index = value;
                  });
                },

                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.restaurant_outlined),
                    label: "Recipes",
                  ),
                  BottomNavigationBarItem(
                    label: "Explore",
                    icon: SizedBox(height: 24),
                  ),

                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_2_outlined),
                    label: "Profile",
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              child: SizedBox(
                height: 56,
                child: FloatingActionButton(
                  onPressed: () => setState(() {
                    index = 1;
                  }),
                  shape: CircleBorder(),
                  backgroundColor: AppColors.primaryColor,
                  child: Icon(Icons.search, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 19, right: 19, top: 58),
          child: bodies[index],
        ),
      ),
    );
  }
}
