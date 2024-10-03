part of 'anak_tanggungan_bloc.dart';

sealed class AnakTanggunganState extends Equatable {
  const AnakTanggunganState();

  @override
  List<Object> get props => [];
}

final class AnakTanggunganInitial extends AnakTanggunganState {}

final class AnakTanggunganLoaded extends AnakTanggunganState {
  final List<DependantInputModel> childData;
  final List<DependantInputModel> otherData;

  const AnakTanggunganLoaded(
      {required this.childData, required this.otherData});
}

class DependantLoading extends AnakTanggunganState {}

class DependantSuccess extends AnakTanggunganState {}

class DependantSuccessAddNew extends AnakTanggunganState {}

class DependantError extends AnakTanggunganState {
  final String msg;

  const DependantError({required this.msg});
}

class DependantNoChanges extends AnakTanggunganState {
  final String msg;

  const DependantNoChanges({required this.msg});
}
