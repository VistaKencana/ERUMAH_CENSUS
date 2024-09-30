part of 'bancian_bloc.dart';

sealed class BancianState extends Equatable {
  const BancianState();
  
  @override
  List<Object> get props => [];
}

final class BancianInitial extends BancianState {}
