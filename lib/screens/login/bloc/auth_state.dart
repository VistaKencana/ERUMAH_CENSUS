part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoginLoading extends AuthState {}

final class AuthLoginSuccess extends AuthState {}

final class AuthLoginError extends AuthState {
  final String msg;
  const AuthLoginError({required this.msg});
}

final class AuthLogoutLoading extends AuthState {}

final class AuthLogoutSuccess extends AuthState {}

final class AuthLogoutError extends AuthState {
  final String msg;
  const AuthLogoutError({required this.msg});
}
