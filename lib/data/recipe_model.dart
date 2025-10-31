
class RecipeModel {
  final int id;
   bool isFav;
  final String mealImage;
  final String countryName;
  final String mealTitle;
  final List<String> mealType;
  final double rating;
  final String cookingTime;
  final List<String> ingredients;
  final List<String> instructions;

  RecipeModel({
this.isFav =false,
    required this.id,
    required this.mealImage,
    required this.countryName,
    required this.mealTitle,
    required this.mealType,
    required this.rating,
    required this.cookingTime,
    required this.ingredients,
    required this.instructions,
  });

  factory RecipeModel.fromJson(Map json) {
    return RecipeModel(
      
      id: json['id'] ?? 0,
      mealImage: json['image'] ?? '',
      countryName: json['cuisine'] ?? '',
      mealTitle: json['name'] ?? '',
      mealType: List<String>.from(json['mealType'] ?? []),
      rating: (json['rating'] ?? 0).toDouble(),
      cookingTime:
          "${(json['prepTimeMinutes'] ?? 0) + (json['cookTimeMinutes'] ?? 0)} min",
      ingredients: List<String>.from(json['ingredients'] ?? []),
      instructions: List<String>.from(json['instructions'] ?? []),
    );
  }
  Map<String, dynamic> toJson() {
    final totalMinutes = int.tryParse(cookingTime.replaceAll(' min', '')) ?? 0;
    return {
      'id': id,
      'image': mealImage,
      'cuisine': countryName,
      'name': mealTitle,
      'mealType': mealType,
      'rating': rating,
      'prepTimeMinutes': totalMinutes,
      'ingredients': ingredients,
      'instructions': instructions,
    };
  }
}

