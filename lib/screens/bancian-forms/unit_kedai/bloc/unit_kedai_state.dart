part of 'unit_kedai_bloc.dart';

sealed class UnitKedaiState extends Equatable {
  const UnitKedaiState();

  @override
  List<Object> get props => [];
}

final class UnitKedaiInitial extends UnitKedaiState {}

final class UnitKedaiLoading extends UnitKedaiState {}

final class UnitKedaiSuccess extends UnitKedaiState {}

final class UnitKedaiNoChanges extends UnitKedaiState {
  final String msg;

  const UnitKedaiNoChanges({required this.msg});
}

final class UnitKedaiError extends UnitKedaiState {
  final String msg;

  const UnitKedaiError({required this.msg});
}
