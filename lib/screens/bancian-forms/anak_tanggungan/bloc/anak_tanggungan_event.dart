part of 'anak_tanggungan_bloc.dart';

sealed class AnakTanggunganEvent extends Equatable {
  const AnakTanggunganEvent();

  @override
  List<Object> get props => [];
}

class SetAnakTanggungData extends AnakTanggunganEvent {
  final ResidentInfoData data;
  final String censusCode;
  const SetAnakTanggungData({required this.data, required this.censusCode});
}

class SaveChildData extends AnakTanggunganEvent {
  final DependantInputModel data;

  const SaveChildData({required this.data});
}

class SaveOtherData extends AnakTanggunganEvent {
  final DependantInputModel data;

  const SaveOtherData({required this.data});
}
