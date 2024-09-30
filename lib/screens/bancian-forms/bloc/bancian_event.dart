part of 'bancian_bloc.dart';

sealed class BancianEvent extends Equatable {
  const BancianEvent();

  @override
  List<Object> get props => [];
}

class SetBancianData extends BancianEvent {
  final ResidentInfoData data;

  const SetBancianData({required this.data});
}
