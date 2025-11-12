part of 'recent_recipes_cubit.dart';

@immutable
sealed class RecentRecipesState {}

final class RecentRecipesInitial extends RecentRecipesState {}

final class RecentRecipesLoading extends RecentRecipesState {}

final class RecentRecipesLoaded extends RecentRecipesState {}
