import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_book_app/cubit/load_recipes_cubit/cubit/load_recipes_cubit.dart';
import 'package:recipe_book_app/widgets/text_form_field.dart';
import '../theme/fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Search", style: Fonts.titlesFont24),
          SizedBox(height: 14),
          TextFomfieldWidget(
            icon: Icon(Icons.search),
            hintText: "Search anything...",
            controller: searchController,
          ),
          SizedBox(height: 20),
          Text("Categories", style: Fonts.darkGreen20),
          SizedBox(height: 14),
          FutureBuilder<Map<String, String>>(
            future: context.read<LoadRecipesCubit>().getCountryandImg(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                final queries = snapshot.data!.entries.toList();
                return GridView.builder(
                  padding: EdgeInsets.all(12),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: queries.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 161 / 80,
                  ),
                  itemBuilder: (context, index) {
                    final country = queries[index].key;
                    final image = queries[index].value;
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<LoadRecipesCubit>().foodByCountry(
                              country,
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
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: image,
                                      fit: BoxFit.cover,
                                      color: Colors.black.withOpacity(0.5),
                                      colorBlendMode: BlendMode.darken,
                                      height: 80,
                                      width: 161,
                                    ),
                                  ),

                                  Text(country, style: Fonts.white160),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
