part of 'dropdown_bloc.dart';

sealed class DropdownState extends Equatable {
  const DropdownState();

  @override
  List<Object> get props => [];
}

final class DropdownInitial extends DropdownState {}

final class DropdownLoading extends DropdownInitial {}

final class DropdownSuccess extends DropdownInitial {
  final List<DropdownData?> data;

  DropdownSuccess({required this.data});
}

final class DropdownError extends DropdownInitial {
  final String msg;
  DropdownError({required this.msg});
}
