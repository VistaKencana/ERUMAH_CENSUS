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
