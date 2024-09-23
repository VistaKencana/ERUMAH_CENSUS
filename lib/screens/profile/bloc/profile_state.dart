part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  final ProfileData data;
  const ProfileSuccess({required this.data});
}

final class ProfileError extends ProfileState {
  final String msg;
  const ProfileError({required this.msg});
}
