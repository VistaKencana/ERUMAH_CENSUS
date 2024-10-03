part of 'bancian_bloc.dart';

sealed class BancianState extends Equatable {
  const BancianState();

  @override
  List<Object> get props => [];
}

final class BancianInitial extends BancianState {}

final class BancianLoading extends BancianState {}

final class BancianSuccess extends BancianState {}

final class BancianError extends BancianState {
  final String msg;

  const BancianError({required this.msg});
}
