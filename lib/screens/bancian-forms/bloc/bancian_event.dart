part of 'bancian_bloc.dart';

sealed class BancianEvent extends Equatable {
  const BancianEvent();

  @override
  List<Object> get props => [];
}

class SetBancianData extends BancianEvent {
  final ResidentInfoData data;
  final String censusCode;

  const SetBancianData({
    required this.data,
    required this.censusCode,
  });
}

class SaveBancianData extends BancianEvent {
  final StatusInputModel data;

  const SaveBancianData({required this.data});
}
