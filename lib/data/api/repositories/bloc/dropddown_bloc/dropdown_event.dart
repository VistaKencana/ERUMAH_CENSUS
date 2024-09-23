// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'dropdown_bloc.dart';

sealed class DropdownEvent extends Equatable {
  const DropdownEvent();

  @override
  List<Object> get props => [];
}

class FetchDdFormData extends DropdownEvent {
  final DdType type;
  const FetchDdFormData({required this.type});
}

class FetchDdFZone extends DropdownEvent {
  const FetchDdFZone();
}

class FetchDdArea extends DropdownEvent {
  const FetchDdArea();
}

class FetchDdBlock extends DropdownEvent {
  const FetchDdBlock();
}

class FetchDdLevel extends DropdownEvent {
  const FetchDdLevel();
}
