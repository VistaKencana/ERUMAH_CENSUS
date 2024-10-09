import 'dart:typed_data';

import 'package:eperumahan_bancian/screens/bancian-forms/models/spouse_input_model.dart';
import 'package:eperumahan_bancian/services/app_log.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../data/api/repositories/application_repository.dart';
import '../../../qr-home/models/resident_info_model.dart';

part 'pasangan_event.dart';
part 'pasangan_state.dart';

class PasanganBloc extends Bloc<PasanganEvent, PasanganState> {
  PasanganBloc() : super(PasanganInitial()) {
    on<SetPasanganData>(_onSetPasanganData);
    on<SavePasanganData>(_onSavePasanganData);
    on<AddNewPasanganData>(_onAddNewPasanganData);
  }

  String censusCode = "";
  final repo = ApplicationRepository();
  final applog = const AppLog(classname: "PasanganBloc");
  ResidentInfoData unitData = ResidentInfoData();
  List<SpouseInputModel> existData = [];
  SpouseInputModel? selectedSpouse;
  int selectedIndex = 0;
  _onSetPasanganData(SetPasanganData event, Emitter<PasanganState> emit) {
    try {
      unitData = event.data;
      existData.clear();
      final data = unitData.toListSpouseJson();
      if (data.isNotEmpty) {
        existData
            .addAll(data.map((e) => SpouseInputModel.fromJson(e)).toList());
      }
      censusCode = event.censusCode;
      applog.logDebug(
          tag: "_onSetPasanganData", msg: "Pasangan: ${existData.length}");
      emit(PasanganLoaded(spouseData: existData));
    } catch (e) {
      applog.logError(tag: "_onSetPasanganData", msg: e.toString());
      emit(PasanganLoaded(spouseData: existData));
    }
  }

  selectPasangan(SpouseInputModel data, int index) {
    selectedSpouse = data;
    selectedIndex = index;
    applog.logDebug(
        tag: "Select Spouse", msg: selectedSpouse!.toJson().toString());
  }

  addNewPasangan({
    required Uint8List frontImg,
    required Uint8List backImg,
  }) {
    selectedSpouse = SpouseInputModel(
        censusCode: censusCode, uploadIcFront: frontImg, uploadIcBack: backImg);
    applog.logDebug(
        tag: "Add Spouse", msg: selectedSpouse!.toJson().toString());
  }

  _onSavePasanganData(
      SavePasanganData event, Emitter<PasanganState> emit) async {
    var origin = selectedSpouse!.toJson().toString();
    var newData = event.data.toJson().toString();
    if (origin.contains(newData)) {
      emit(const PasanganNoChanges(msg: "Tiada Perubahan Dibuat"));
      emit(PasanganLoaded(spouseData: existData));
      return;
    }
    emit(PasanganLoading());
    applog.logDebug(tag: "Send Item", msg: event.data.toJson().toString());
    try {
      final resp = await repo.storeSpouse(data: event.data);
      applog.logDebug(tag: "_onSavePasanganData", msg: resp);
      existData[selectedIndex] = event.data;
      emit(PasanganSuccess());
    } catch (e) {
      applog.logError(tag: "_onSavePasanganData", msg: e.toString());
      emit(PasanganError(msg: e.toString()));
    } finally {
      emit(PasanganLoaded(spouseData: existData));
      EasyLoading.dismiss();
    }
  }

  _onAddNewPasanganData(
      AddNewPasanganData event, Emitter<PasanganState> emit) async {
    emit(PasanganLoading());
    applog.logDebug(tag: "Send Item", msg: event.data.toJson().toString());
    try {
      final resp = await repo.storeSpouse(data: event.data);
      applog.logDebug(tag: "_onAddNewPasanganData", msg: resp);
      existData.add(event.data);
      emit(PasanganSuccess());
    } catch (e) {
      applog.logError(tag: "_onAddNewPasanganData", msg: e.toString());
      emit(PasanganError(msg: e.toString()));
    } finally {
      emit(PasanganLoaded(spouseData: existData));
      EasyLoading.dismiss();
    }
  }
}
