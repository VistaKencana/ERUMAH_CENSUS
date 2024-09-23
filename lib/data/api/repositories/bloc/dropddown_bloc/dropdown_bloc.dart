import 'package:eperumahan_bancian/data/api/repositories/dropdown_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/dropdown_model.dart';
import 'dart:developer' as dev;
part 'dropdown_event.dart';
part 'dropdown_state.dart';

class DropdownBloc extends Bloc<DropdownEvent, DropdownState> {
  DropdownBloc() : super(DropdownInitial()) {
    on<FetchDdFormData>(_onFetchDdData);
  }

  //Temparory variable
  List<DropdownData?> allList = [];
  List<DropdownData?> zoneList = [];
  List<DropdownData?> parliamentList = [];
  List<DropdownData?> raceList = [];
  List<DropdownData?> genderList = [];
  List<DropdownData?> maritalStatusList = [];
  List<DropdownData?> occupationTypeList = [];
  List<DropdownData?> censusStatusList = [];
  List<DropdownData?> relationshipList = [];
  List<DropdownData?> healthLevelList = [];

  final repo = DropdownRepository();

  _onFetchDdData(FetchDdFormData event, Emitter<DropdownState> emit) async {
    final dropdownType = event.type;
    var listData = _getDropdownList(type: dropdownType);
    if (listData.isNotEmpty) {
      emit(DropdownSuccess(data: listData));
      return;
    }
    emit(DropdownLoading());
    try {
      final resp = await repo.getDropdownData(type: dropdownType);
      listData = resp;
      emit(DropdownSuccess(data: listData));
    } catch (e) {
      dev.log(e.toString());
      emit(DropdownError(msg: e.toString()));
    }
  }

  List<DropdownData?> _getDropdownList({required DdType type}) {
    final listData = {
      DdType.all: allList,
      DdType.zone: zoneList,
      DdType.parliament: parliamentList,
      DdType.race: raceList,
      DdType.gender: genderList,
      DdType.maritalStatus: maritalStatusList,
      DdType.occupationType: occupationTypeList,
      DdType.censusStatus: censusStatusList,
      DdType.relationship: relationshipList,
      DdType.healthLevel: healthLevelList,
    };
    return listData[type] ?? [];
  }
}
