part of 'pasangan_bloc.dart';

sealed class PasanganState extends Equatable {
  const PasanganState();

  @override
  List<Object> get props => [];
}

final class PasanganInitial extends PasanganState {}

final class PasanganLoaded extends PasanganState {
  final List<SpouseInputModel> spouseData;

  const PasanganLoaded({required this.spouseData});
}

final class PasanganLoading extends PasanganState {}

final class PasanganSuccess extends PasanganState {}

final class PasanganError extends PasanganState {
  final String msg;

  const PasanganError({required this.msg});
}

class PasanganNoChanges extends PasanganState {
  final String msg;

  const PasanganNoChanges({required this.msg});
}
