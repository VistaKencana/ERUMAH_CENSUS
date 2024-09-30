part of 'penghuni_bloc.dart';

sealed class PenghuniEvent extends Equatable {
  const PenghuniEvent();

  @override
  List<Object> get props => [];
}

class SetPenghuniData extends PenghuniEvent {
  final ResidentInfoData data;

  const SetPenghuniData({required this.data});
}
