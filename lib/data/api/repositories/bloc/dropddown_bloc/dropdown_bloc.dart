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

  //Temparory variable
  List<DropdownData> raceList = [];
  List<DropdownData> genderList = [];
  List<DropdownData> maritalStatusList = [];
  List<DropdownData> occupationTypeList = [];
  List<DropdownData> censusStatusList = [];
  List<DropdownData> relationshipList = [];
  List<DropdownData> healthLevelList = [];

  final repo = DropdownRepository();
  final log = const AppLog(classname: "DropdownBloc");
  _onFetchDdData(FetchDdFormData event, Emitter<DropdownState> emit) async {
    final dropdownType = event.type;
    var listData = _getDropdownList(type: dropdownType);
    if (listData.isNotEmpty) {
      emit(DropdownSuccess(data: listData));
      return;
    }
    emit(DropdownLoading());
    EasyLoading.show();
    try {
      final resp = await repo.getDropdownData(type: dropdownType);
      listData = resp;
      emit(DropdownSuccess(data: listData));
    } catch (e) {
      log.logError(tag: "_onFetchDdData", msg: e.toString());
      emit(DropdownError(msg: e.toString()));
    } finally {
      EasyLoading.dismiss();
    }
  }

  List<DropdownData?> _getDropdownList({required DdType type}) {
    final listData = {
      DdType.race: raceList,
      DdType.gender: genderList,
      DdType.maritalStatus: maritalStatusList,
      DdType.occupationType: occupationTypeList,
      DdType.relationship: relationshipList,
      DdType.healthLevel: healthLevelList,
      DdType.censusStatus: censusStatusList,
    };
    return listData[type] ?? [];
  }
}
