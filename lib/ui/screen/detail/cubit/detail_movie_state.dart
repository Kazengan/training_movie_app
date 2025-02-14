part of 'detail_movie_cubit.dart';

@immutable
sealed class DetailMovieState {}

final class DetailMovieInitial extends DetailMovieState {}

final class DetailMovieLoading extends DetailMovieState {}

final class DetailMoviesLoaded extends DetailMovieState {
  final DetailMovieEntity data;

  DetailMoviesLoaded({required this.data});
}

final class DetailMovieFailed extends DetailMovieState {
  final String message;

  DetailMovieFailed({required this.message});
}
