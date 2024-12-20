import 'package:eperumahan_bancian/data/api/repositories/application_repository.dart';
import 'package:eperumahan_bancian/main.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/models/status_input_model.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/models/subrent_input_model.dart';
import 'package:eperumahan_bancian/services/app_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../services/flushbar/custom_flushbar.dart';

class SubrentProvider extends ChangeNotifier {
  final repo = ApplicationRepository();
  final appLog = const AppLog(classname: "SubrentProvider");
  String censusCode = "";
  List<SubrentInputModel> listSubrent = [];
  SubrentInputModel selectedSubrent = SubrentInputModel();
  void initialize() {
    notifyListeners();
  }

  void setCensusCode({required String val}) {
    censusCode = val;
    notifyListeners();
  }

  void clearListSUbrent() {
    listSubrent.clear();
    notifyListeners();
  }

  void selectSubrent(SubrentInputModel val) {
    selectedSubrent = val;
    selectedSubrent = selectedSubrent.copyWith(censusCode: censusCode);
    notifyListeners();
  }

  Future<void> submitStatus({required StatusInputModel data}) async {
    if (listSubrent.isEmpty) {
      final context = navigatorKey.currentContext!;
      CustomFlushbar.of(context).showInfo(msg: "Sila tambah subrent");
      return;
    }

    EasyLoading.show();
    appLog.logDebug(tag: "Send Item", msg: data.toJson().toString());
    try {
      final resp = await repo.storeStatus(data: data);
      appLog.logDebug(tag: "submitStatus", msg: resp);
    } catch (e) {
      appLog.logError(tag: "submitStatus", msg: e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> submitSubrent({required SubrentInputModel data}) async {
    data = data.copyWith(censusCode: censusCode);

    var origin = selectedSubrent
        .copyWith(isChangeOnImage: false)
        .toValidate()
        .toString();
    var newData = data.toString();
    if (origin.contains(newData)) {
      final context = navigatorKey.currentContext!;
      CustomFlushbar.of(context).showInfo(msg: "Tiada Perubahan Dibuat");
      return;
    }
    appLog.logDebug(tag: "Send Item", msg: data.toJson().toString());
    try {
      EasyLoading.show();
      // final resp = await repo.storeSubrent(data: data);
      // appLog.logDebug(tag: "Response", msg: resp);
      //Add to list and pop
      EasyLoading.dismiss();
      final context = navigatorKey.currentContext!;
      if (context.mounted) {
        listSubrent.add(data);
        selectedSubrent = data;
        notifyListeners();
        Navigator.pop(context);
        CustomFlushbar.of(context).showSuccess(msg: "Berjaya menmyimpan data");
      }
    } catch (e) {
      appLog.logError(tag: "storeSubrent", msg: e.toString());
      final context = navigatorKey.currentContext!;
      if (context.mounted) {
        CustomFlushbar.of(context).showFailed(msg: e.toString());
      }
    } finally {
      EasyLoading.dismiss();
      notifyListeners();
    }
  }

  Future<void> updateSubrent({required SubrentInputModel data}) async {
    int index = listSubrent.indexWhere(
      (subrent) => subrent.icNo == data.icNo,
    );

    if (index == -1) {
      final context = navigatorKey.currentContext!;
      if (context.mounted) {
        CustomFlushbar.of(context).showFailed(msg: "Subrent not found");
      }
      return;
    }

    var origin = selectedSubrent
        .copyWith(isChangeOnImage: false)
        .toValidate()
        .toString();

    var newData = data.toValidate().toString();
    if (origin.contains(newData)) {
      final context = navigatorKey.currentContext!;
      CustomFlushbar.of(context).showInfo(msg: "Tiada Perubahan Dibuat");
      return;
    }
    appLog.logDebug(tag: "Send Update Item", msg: data.toJson().toString());
    try {
      EasyLoading.show();
      // final resp = await repo.storeSubrent(data: data);
      // appLog.logDebug(tag: "Response", msg: resp);
      //Add to list and pop
      EasyLoading.dismiss();
      final context = navigatorKey.currentContext!;
      if (context.mounted) {
        listSubrent[index] = data.copyWith(isChangeOnImage: false);
        selectedSubrent = data.copyWith(isChangeOnImage: false);
        notifyListeners();
        CustomFlushbar.of(context).showSuccess(msg: "Berjaya menyimpan data");
      }
    } catch (e) {
      appLog.logError(tag: "storeSubrent", msg: e.toString());
      final context = navigatorKey.currentContext!;
      if (context.mounted) {
        CustomFlushbar.of(context).showFailed(msg: e.toString());
      }
    } finally {
      EasyLoading.dismiss();
      notifyListeners();
    }
  }
}
