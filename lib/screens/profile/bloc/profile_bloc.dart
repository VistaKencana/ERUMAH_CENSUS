import 'dart:io';

import 'package:eperumahan_bancian/data/api/repositories/profile_repository.dart';
import 'package:eperumahan_bancian/screens/profile/model/profile_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as dev;

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<FetchProfile>(_onFetchProfile);
  }

  final repo = ProfileRepository();
  ProfileData profileData = ProfileData();
  _onFetchProfile(FetchProfile event, Emitter<ProfileState> emit) async {
    profileData = ProfileData();
    emit(ProfileLoading());
    try {
      final resp = await repo.getUserProfile();
      profileData = resp.data!;
      dev.log(profileData.toJson().toString());
      emit(ProfileSuccess(data: profileData));
    } on SocketException {
      emit(const ProfileError(msg: "No internet connection"));
    } catch (e) {
      dev.log(e.toString());
      emit(ProfileError(msg: e.toString()));
    }
  }
}
