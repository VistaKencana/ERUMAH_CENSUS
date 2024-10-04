import 'dart:typed_data';

import 'package:eperumahan_bancian/screens/bancian-forms/models/dependant_input_model.dart';
import 'package:eperumahan_bancian/screens/qr-home/models/resident_info_model.dart';
import 'package:eperumahan_bancian/services/app_log.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../data/api/repositories/application_repository.dart';

part 'anak_tanggungan_event.dart';
part 'anak_tanggungan_state.dart';

class AnakTanggunganBloc
    extends Bloc<AnakTanggunganEvent, AnakTanggunganState> {
  AnakTanggunganBloc() : super(AnakTanggunganInitial()) {
    on<SetAnakTanggungData>(_onSetAnakTanggungData);
    on<SaveChildData>(_onSaveChildData);
    on<SaveOtherData>(_onSaveOtherData);
    on<AddChildData>(_onAddChildData);
    on<AddOtherData>(_onAddOtherData);
  }

  String censusCode = "";
  ResidentInfoData unitData = ResidentInfoData();
  List<DependantInputModel> existChild = [];
  List<DependantInputModel> existOthers = [];
  DependantInputModel? selectedData;
  int selectedIndex = 0;
  final repo = ApplicationRepository();
  final applog = const AppLog(classname: "AnakTanggunganBloc");
  _onSetAnakTanggungData(
      SetAnakTanggungData event, Emitter<AnakTanggunganState> emit) {
    try {
      unitData = event.data;
      existChild.clear();
      final data = unitData.toDependantChildJson();
      (data);
      if (data.isNotEmpty) {
        existChild
            .addAll(data.map((e) => DependantInputModel.fromJson(e)).toList());
      }

      existOthers.clear();
      final data2 = unitData.toDependantOtherJson();
      if (data2.isNotEmpty) {
        existOthers
            .addAll(data2.map((e) => DependantInputModel.fromJson(e)).toList());
      }
      applog.logDebug(
          tag: "_onSetAnakTanggungData",
          msg: "Child: ${existChild.length}, Other: ${existOthers.length}");
      censusCode = event.censusCode;
      emit(AnakTanggunganLoaded(childData: existChild, otherData: existOthers));
    } catch (e) {
      applog.logError(tag: "_onSetAnakTanggungData", msg: e.toString());
    }
  }

  _onSaveChildData(
      SaveChildData event, Emitter<AnakTanggunganState> emit) async {
    var origin = selectedData!.toJson().toString();
    var newData = event.data.toJson().toString();
    if (origin.contains(newData)) {
      emit(const DependantNoChanges(msg: "Tiada Perubahan Dibuat"));
      emit(AnakTanggunganLoaded(childData: existChild, otherData: existOthers));
      return;
    }
    emit(DependantLoading());
    applog.logDebug(tag: "Send Item", msg: event.data.toJson().toString());
    try {
      final resp = await repo.storeDependant(data: event.data);
      applog.logDebug(tag: "_onSaveChildData", msg: resp);
      existChild[selectedIndex] = event.data;
      selectedData = event.data;
      emit(DependantSuccess());
    } catch (e) {
      applog.logError(tag: "_onSaveChildData", msg: e.toString());
      emit(DependantError(msg: e.toString()));
    } finally {
      emit(AnakTanggunganLoaded(childData: existChild, otherData: existOthers));
      EasyLoading.dismiss();
    }
  }

  _onAddChildData(AddChildData event, Emitter<AnakTanggunganState> emit) async {
    emit(DependantLoading());
    applog.logDebug(tag: "Send Item", msg: event.data.toJson().toString());
    try {
      final resp = await repo.storeDependant(data: event.data);
      applog.logDebug(tag: "_onAddChildData", msg: resp);
      existChild.add(event.data);
      selectedData = event.data;
      emit(DependantSuccessAddNew());
    } catch (e) {
      applog.logError(tag: "_onAddChildData", msg: e.toString());
      emit(DependantError(msg: e.toString()));
    } finally {
      emit(AnakTanggunganLoaded(childData: existChild, otherData: existOthers));
      EasyLoading.dismiss();
    }
  }

  _onSaveOtherData(
      SaveOtherData event, Emitter<AnakTanggunganState> emit) async {
    var origin = selectedData!.toJson().toString();
    var newData = event.data.toJson().toString();
    if (origin.contains(newData)) {
      emit(const DependantNoChanges(msg: "Tiada Perubahan Dibuat"));
      emit(AnakTanggunganLoaded(childData: existChild, otherData: existOthers));
      return;
    }
    emit(DependantLoading());
    applog.logDebug(tag: "Send Item", msg: event.data.toJson().toString());
    try {
      final resp = await repo.storeDependant(data: event.data);
      applog.logDebug(tag: "_onSaveOtherData", msg: resp);
      selectedData = event.data;
      existOthers[selectedIndex] = event.data;
      emit(DependantSuccess());
    } catch (e) {
      applog.logError(tag: "_onSaveOtherData", msg: e.toString());
      emit(DependantError(msg: e.toString()));
    } finally {
      emit(AnakTanggunganLoaded(childData: existChild, otherData: existOthers));
      EasyLoading.dismiss();
    }
  }

  _onAddOtherData(AddOtherData event, Emitter<AnakTanggunganState> emit) async {
    emit(DependantLoading());
    applog.logDebug(tag: "Send Item", msg: event.data.toJson().toString());
    try {
      final resp = await repo.storeDependant(data: event.data);
      applog.logDebug(tag: "_onAddOtherData", msg: resp);
      selectedData = event.data;
      existOthers.add(event.data);
      emit(DependantSuccessAddNew());
    } catch (e) {
      applog.logError(tag: "_onAddOtherData", msg: e.toString());
      emit(DependantError(msg: e.toString()));
    } finally {
      emit(AnakTanggunganLoaded(childData: existChild, otherData: existOthers));
      EasyLoading.dismiss();
    }
  }

  selectDependant(DependantInputModel data, int index) {
    selectedData = data;
    selectedIndex = index;
    applog.logDebug(
        tag: "Select Dependant", msg: selectedData!.toJson().toString());
  }

  addNewChild({
    required Uint8List frontImg,
    required Uint8List backImg,
  }) {
    //Setting new object for new child
    selectedData = DependantInputModel(
        censusCode: censusCode,
        relationshipCode: "RSP001",
        relationshipDesc: "Anak",
        uploadIcFront: frontImg,
        uploadIcBack: backImg);
    applog.logDebug(tag: "Add Child", msg: selectedData!.toJson().toString());
  }

  addNewDependant({
    required Uint8List frontImg,
    required Uint8List backImg,
  }) {
    //Setting new object for new dependant
    selectedData = DependantInputModel(
        censusCode: censusCode, uploadIcFront: frontImg, uploadIcBack: backImg);
    applog.logDebug(
        tag: "Add Dependant", msg: selectedData!.toJson().toString());
  }
}
