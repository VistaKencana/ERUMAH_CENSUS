part of 'penghuni_bloc.dart';

sealed class PenghuniState extends Equatable {
  const PenghuniState();

  @override
  List<Object> get props => [];
}

final class PenghuniInitial extends PenghuniState {}
