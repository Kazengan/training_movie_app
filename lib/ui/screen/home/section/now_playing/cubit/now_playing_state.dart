part of 'now_playing_cubit.dart';

@immutable
sealed class NowPlayingState {}

final class NowPlayingInitial extends NowPlayingState {}

final class NowPlayingLoading extends NowPlayingState {}

final class NowPlayingLoaded extends NowPlayingState {
  final List<MovieEntity> data;
  NowPlayingLoaded({required this.data});
}

final class NowPlayingFailed extends NowPlayingState {
  final String message;
  NowPlayingFailed({required this.message});
}
