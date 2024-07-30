import 'dart:io';

import 'package:eperumahan_bancian/data/api/repositories/auth_repository.dart';
import 'package:eperumahan_bancian/data/hive-manager/repository/login_pref.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<UserLogin>(_onUserLogin);
    on<UserLogout>(_onUserLogout);
  }

  final repo = AuthRepository();
  _onUserLogin(UserLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoginLoading());
    try {
      final resp =
          await repo.userLogin(userCode: event.userCode, password: event.pwd);
      await LoginPreference().saveData(model: resp);
      emit(AuthLoginSuccess());
    } on SocketException {
      emit(const AuthLoginError(msg: "No internet connection"));
    } catch (e) {
      emit(AuthLoginError(msg: e.toString()));
    }
  }

  _onUserLogout(UserLogout event, Emitter<AuthState> emit) async {
    emit(AuthLogoutLoading());
    try {
      final isSuccess = await repo.userLogout();
      if (!isSuccess) {
        emit(const AuthLogoutError(msg: "Something went wrong"));
        return;
      }
      await LoginPreference.clearData();
      emit(AuthLogoutSuccess());
    } on SocketException {
      emit(const AuthLogoutError(msg: "No internet connection"));
    } catch (e) {
      emit(AuthLogoutError(msg: e.toString()));
    }
  }
}
