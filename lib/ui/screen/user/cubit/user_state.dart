part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserLoaded extends UserState {
  final UserDetailEntity data;

  UserLoaded({required this.data});
}

final class UserFailed extends UserState {
  final String message;

  UserFailed({required this.message});
}
