part of 'unit_kedai_bloc.dart';

sealed class UnitKedaiEvent extends Equatable {
  const UnitKedaiEvent();

  @override
  List<Object> get props => [];
}

class SetPemilikData extends UnitKedaiEvent {
  final ResidentInfoData data;
  final String censusCode;
  const SetPemilikData({required this.data, required this.censusCode});
}

class SavePemilikData extends UnitKedaiEvent {
  final UnitKedaiInputModel data;

  const SavePemilikData({required this.data});
}
