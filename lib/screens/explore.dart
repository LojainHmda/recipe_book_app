import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_book_app/cubit/load_recipes_cubit/cubit/load_recipes_cubit.dart';
import 'package:recipe_book_app/widgets/text_form_field.dart';
import '../theme/fonts.dart';
import 'food_list_by_country.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {    final TextEditingController searchController = TextEditingController();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Search", style: Fonts.titlesFont24),
          SizedBox(height: 14),
          TextFomfieldWidget(
            icon: Icon(Icons.search),
            hintText: "Search anything...", controller:searchController ,
          ),
          SizedBox(height: 20),
          Text("Categories", style: Fonts.darkGreen20),
          SizedBox(height: 14),
          BlocBuilder<LoadRecipesCubit, LoadRecipesState>(
            builder: (context, state) {
              List countries = context
                  .read<LoadRecipesCubit>()
                  .countryAndImage
                  .keys
                  .toList();

              List images = context
                  .read<LoadRecipesCubit>()
                  .countryAndImage
                  .values
                  .toList();
              if (state is LoadedRecipesState) {
                return GridView.builder(
                  padding: EdgeInsets.all(12),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: countries.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 161 / 80,
                  ),
                  itemBuilder: (context, index) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<LoadRecipesCubit>().foodByCountry(
                              countries[index],
                            );
                            Navigator.pushNamed(context, '/foodListByCountry');
                          },
                          child: Container(
                            height: 80,
                            width: 161,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.network(
                                    images[index],
                                    fit: BoxFit.cover,
                                    color: Colors.black.withOpacity(0.5),
                                    colorBlendMode: BlendMode.darken,
                                    height: 80,
                                    width: 161,
                                  ),
                                  Text(countries[index], style: Fonts.white160),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Text(countries[index], style: Fonts.white160),
                      ],
                    );
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
