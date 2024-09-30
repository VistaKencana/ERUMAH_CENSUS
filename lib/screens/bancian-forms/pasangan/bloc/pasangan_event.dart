part of 'pasangan_bloc.dart';

sealed class PasanganEvent extends Equatable {
  const PasanganEvent();

  @override
  List<Object> get props => [];
}

class SetPasanganData extends PasanganEvent {
  final ResidentInfoData data;

  const SetPasanganData({required this.data});
}
