part of 'pasangan_bloc.dart';

sealed class PasanganEvent extends Equatable {
  const PasanganEvent();

  @override
  List<Object> get props => [];
}

class SetPasanganData extends PasanganEvent {
  final ResidentInfoData data;
  final String censusCode;
  const SetPasanganData({required this.data, required this.censusCode});
}

class SavePasanganData extends PasanganEvent {
  final SpouseInputModel data;

  const SavePasanganData({required this.data});
}

class AddNewPasanganData extends PasanganEvent {
  final SpouseInputModel data;

  const AddNewPasanganData({required this.data});
}
