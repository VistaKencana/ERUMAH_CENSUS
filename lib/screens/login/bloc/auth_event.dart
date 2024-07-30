part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class UserLogin extends AuthEvent {
  final String userCode, pwd;

  const UserLogin({
    required this.userCode,
    required this.pwd,
  });
}

class UserLogout extends AuthEvent {}
