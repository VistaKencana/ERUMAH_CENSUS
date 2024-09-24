part of 'property_bloc.dart';

sealed class PropertyState extends Equatable {
  const PropertyState();
  
  @override
  List<Object> get props => [];
}

final class PropertyInitial extends PropertyState {}
