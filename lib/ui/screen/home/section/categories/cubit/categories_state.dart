part of 'categories_cubit.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoading extends CategoriesState {}

final class CategoriesLoaded extends CategoriesState {
  final List<GenreEntity> data;

  CategoriesLoaded({required this.data});
}

final class CategoriesFailed extends CategoriesState {
  final String message;

  CategoriesFailed({required this.message});
}
