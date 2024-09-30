part of 'penghuni_bloc.dart';

sealed class PenghuniState extends Equatable {
  const PenghuniState();

  @override
  List<Object> get props => [];
}

final class PenghuniInitial extends PenghuniState {}

final class PenghuniLoading extends PenghuniState {}

final class PenghuniLoaded extends PenghuniState {}

final class PenghuniError extends PenghuniState {}
