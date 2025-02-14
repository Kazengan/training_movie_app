part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthLoaded extends AuthState {
  final UserEntity user;

  AuthLoaded({required this.user});
}

final class AuthFailed extends AuthState {
  final String message;

  AuthFailed({required this.message});
}

final class AuthPasswordVisibilityChanged extends AuthState {
  final bool isVisible;

  AuthPasswordVisibilityChanged(this.isVisible);
}
