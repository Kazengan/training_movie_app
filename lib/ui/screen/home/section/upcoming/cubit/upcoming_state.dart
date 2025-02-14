part of 'upcoming_cubit.dart';

@immutable
sealed class UpcomingState {}

final class UpcomingInitial extends UpcomingState {}

final class UpcomingLoading extends UpcomingState {}

final class UpcomingLoaded extends UpcomingState {
  final List<MovieEntity> data;
  UpcomingLoaded({required this.data});
}

final class UpcomingFailed extends UpcomingState {
  final String message;
  UpcomingFailed({required this.message});
}
