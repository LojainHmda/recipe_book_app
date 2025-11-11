part of 'load_recipes_cubit.dart';

abstract class LoadRecipesState {}

final class LoadRecipesInitial extends LoadRecipesState {}

final class LoadingRecipesState extends LoadRecipesState {}

final class LoadedRecipesState extends LoadRecipesState {
  final List<RecipeModel> allRecipes;

  LoadedRecipesState({required this.allRecipes});
}
