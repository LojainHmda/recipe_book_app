
import 'package:flutter/material.dart';
import 'package:recipe_book_app/screens/explore.dart';
import 'package:recipe_book_app/screens/recipes.dart';

import 'screens/profile.dart';

void main() {
  runApp(MaterialApp(home: HomeScreen()));
}

class HomeScreen extends StatefulWidget {
 HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<HomeScreen> {
  int index = 0;

  List<Widget> bodeis = [RecipesScreen(), ExploreScreen(), ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
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
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Explore"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
        body: bodeis[index],
      ),
    );
  }
}
