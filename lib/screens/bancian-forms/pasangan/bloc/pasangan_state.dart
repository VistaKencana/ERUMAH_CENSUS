part of 'pasangan_bloc.dart';

sealed class PasanganState extends Equatable {
  const PasanganState();
  
  @override
  List<Object> get props => [];
}

final class PasanganInitial extends PasanganState {}
