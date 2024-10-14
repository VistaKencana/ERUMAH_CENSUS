part of 'property_bloc.dart';

sealed class PropertyState extends Equatable {
  const PropertyState();

  @override
  List<Object> get props => [];
}

final class PropertyInitial extends PropertyState {}

final class PropertyLoading extends PropertyState {}

final class PropertySuccess extends PropertyState {}

final class PropertyError extends PropertyState {
  final String msg;
  const PropertyError({required this.msg});
}

final class UnitLoading extends PropertyState {}

final class UnitSuccess extends PropertyState {}

final class UnitError extends PropertyState {
  final String msg;
  const UnitError({required this.msg});
}
