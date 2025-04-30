import 'dart:convert';
import 'dart:typed_data';

import 'package:eperumahan_bancian/data/api/repositories/application_repository.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/models/status_input_model.dart';
import 'package:eperumahan_bancian/screens/qr-home/models/resident_info_model.dart';
import 'package:eperumahan_bancian/services/app_log.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

part 'bancian_event.dart';
part 'bancian_state.dart';

class BancianBloc extends Bloc<BancianEvent, BancianState> {
  BancianBloc() : super(BancianInitial()) {
    on<SetBancianData>(_onSetBancianData);
    on<SaveBancianData>(_onSaveBancianData);
  }
  final applog = const AppLog(classname: "BancianBloc");
  final repo = ApplicationRepository();
  ResidentInfoData unitData = ResidentInfoData();
  StatusInputModel? statusData;
  StatusInputModel? statusNotOwnerData;
  String houseStatus = ""; // UNS003:unit kosong
  String unitTypeCode = ""; //
  bool isLampiranSuccess = false;
  _onSetBancianData(SetBancianData event, Emitter<BancianState> emit) {
    unitData = event.data;
    houseStatus = unitData.unit?.statusCode ?? "";
    unitTypeCode = unitData.unit?.typeCode ?? "";
    statusData = StatusInputModel(
        censusCode: unitData.censusCode ?? '',
        isFingerPrintVerified: "0",
        remark: "");
  }

  _onSaveBancianData(SaveBancianData event, Emitter<BancianState> emit) async {
    emit(BancianLoading());
    applog.logDebug(tag: "Send Item", msg: event.data.toJson().toString());
    try {
      final resp = await repo.storeStatus(data: event.data);
      final json = jsonDecode(resp);
      final data = json['data'];
      isLampiranSuccess = (data['censusStatus'] as String)
          .toLowerCase()
          .contains("tidak lengkap");
      applog.logDebug(tag: "_onSavePenghuniData", msg: resp);
      emit(BancianSuccess());
    } catch (e) {
      applog.logError(tag: "_onSaveBancianData", msg: e.toString());
      emit(BancianError(msg: e.toString()));
    } finally {
      EasyLoading.dismiss();
    }
  }

  setImages({required List<Uint8List> imgs}) {
    statusData = statusData!.copyWith(images: imgs);
  }

  initNotOwner() {
    statusNotOwnerData = StatusInputModel(
        censusCode: unitData.censusCode ?? '',
        isFingerPrintVerified: "0",
        remark: "",
        images: statusData?.images ?? []);
    applog.logDebug(
        tag: "Init Not Owner", msg: statusNotOwnerData!.toJson().toString());
  }
}
