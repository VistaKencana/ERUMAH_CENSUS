import 'package:eperumahan_bancian/data/api/repositories/dropdown_repository.dart';
import 'package:eperumahan_bancian/services/app_log.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/foundation.dart';

import '../model/dropdown_model.dart';

class DropdownProvider extends ChangeNotifier {
  // Temporarily store dropdown data
  List<DropdownData> raceList = [];
  List<DropdownData> genderList = [];
  List<DropdownData> maritalStatusList = [];
  List<DropdownData> occupationTypeList = [];
  List<DropdownData> censusStatusList = [];
  List<DropdownData> relationshipList = [];
  List<DropdownData> healthLevelList = [];

  final repo = DropdownRepository();
  final log = const AppLog(classname: "DropdownProvider");

  bool isLoading = false;
  String errorMessage = '';

  // Fetch dropdown data based on type
  Future<void> fetchDropdownData(DdType type) async {
    var listData = _getDropdownList(type: type);
    if (listData.isNotEmpty) {
      return;
    }

    EasyLoading.show();

    try {
      final resp = await repo.getDropdownData(type: type);
      listData = resp;
      _updateDropdownList(type: type, data: listData);
    } catch (e) {
      log.logError(tag: "fetchDropdownData", msg: e.toString());
      errorMessage = e.toString();
    } finally {
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
    }
    notifyListeners(); // Notify listeners after data changes
  }
}
