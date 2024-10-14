part of 'penghuni_bloc.dart';

sealed class PenghuniEvent extends Equatable {
  const PenghuniEvent();

  @override
  List<Object> get props => [];
}

class SetPenghuniData extends PenghuniEvent {
  final ResidentInfoData data;
  final String censusCode;
  const SetPenghuniData({required this.data, required this.censusCode});
}

class SavePenghuniData extends PenghuniEvent {
  final OwnerInputModel data;

  const SavePenghuniData({required this.data});
}
class SaveBukanPenghuniData extends PenghuniEvent {
  final OwnerInputModel data;

  const SaveBukanPenghuniData({required this.data});
}
