import 'package:eperumahan_bancian/data/api/repositories/dropdown_repository.dart';
import 'package:eperumahan_bancian/services/app_log.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../model/dropdown_model.dart';
part 'dropdown_event.dart';
part 'dropdown_state.dart';

class DropdownBloc extends Bloc<DropdownEvent, DropdownState> {
  DropdownBloc() : super(DropdownInitial()) {
    on<FetchDdFormData>(_onFetchDdData);
  }

  //Temporarily store dropdown data
  List<DropdownData> raceList = [];
  List<DropdownData> genderList = [];
  List<DropdownData> maritalStatusList = [];
  List<DropdownData> occupationTypeList = [];
  List<DropdownData> censusStatusList = [];
  List<DropdownData> relationshipList = [];
  List<DropdownData> healthLevelList = [];
  List<DropdownData> businessTypeList = [];

  final repo = DropdownRepository();
  final log = const AppLog(classname: "DropdownBloc");

  void _onFetchDdData(
      FetchDdFormData event, Emitter<DropdownState> emit) async {
    emit(DropdownLoading());
    final dropdownType = event.type;
    var listData = _getDropdownList(type: dropdownType);

    if (listData.isNotEmpty) {
      emit(DropdownSuccess(data: listData, type: event.type));
      return;
    }

    EasyLoading.show();

    try {
      final resp = await repo.getDropdownData(type: dropdownType);

      // Update the respective list based on the type
      listData = resp;
      _updateDropdownList(type: dropdownType, data: listData);

      emit(DropdownSuccess(data: listData, type: event.type));
    } catch (e) {
      log.logError(tag: "_onFetchDdData", msg: e.toString());
      emit(DropdownError(msg: e.toString()));
    } finally {
      emit(DropdownSuccess(data: listData, type: event.type));
      EasyLoading.dismiss();
    }
  }

  // Get the list for the specific dropdown type
  List<DropdownData> _getDropdownList({required DdType type}) {
    final listData = {
      DdType.race: raceList,
      DdType.gender: genderList,
      DdType.maritalStatus: maritalStatusList,
      DdType.occupationType: occupationTypeList,
      DdType.relationship: relationshipList,
      DdType.healthLevel: healthLevelList,
      DdType.censusStatus: censusStatusList,
      DdType.businessType: businessTypeList,
    };
    return listData[type] ?? [];
  }

  // Update the list based on the dropdown type
  void _updateDropdownList(
      {required DdType type, required List<DropdownData> data}) {
    switch (type) {
      case DdType.race:
        raceList = data;
        break;
      case DdType.gender:
        genderList = data;
        break;
      case DdType.maritalStatus:
        maritalStatusList = data;
        break;
      case DdType.occupationType:
        occupationTypeList = data;
        break;
      case DdType.relationship:
        relationshipList = data;
        break;
      case DdType.healthLevel:
        healthLevelList = data;
        break;
      case DdType.censusStatus:
        censusStatusList = data;
        break;
      case DdType.businessType:
        businessTypeList = data;
        break;
    }
  }
}
