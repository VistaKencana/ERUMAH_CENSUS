import 'package:eperumahan_bancian/data/api/repositories/model/zone_model.dart';
import 'package:eperumahan_bancian/data/api/repositories/qr_repository.dart';
import 'package:eperumahan_bancian/screens/qr-home/models/resident_info_model.dart';
import 'package:eperumahan_bancian/services/app_log.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../data/api/repositories/model/area_model.dart';
import '../../../data/api/repositories/model/block_model.dart';
import '../../../data/api/repositories/model/floor_model.dart';
import '../../../data/api/repositories/model/property_model.dart';

part 'qr_event.dart';
part 'qr_state.dart';

class QrBloc extends Bloc<QrEvent, QrState> {
  QrBloc() : super(QrInitial()) {
    on<ScanQrcode>(_onScanQrcode);
    on<RegisterQrcode>(_onRegisterQrcode);
    on<UpdateQrcode>(_onUpdateQrcode);
  }

  final repo = QrRepository();
  final log = const AppLog(classname: "QrBloc");
  var residentData = ResidentInfoData();
  String qrCode = "";
  bool isFromHome = false;

  //Register data
  ZoneData selectedZone = ZoneData();
  AreaData selectedArea = AreaData();
  BlockData selectedBlock = BlockData();
  FloorData selectedFloor = FloorData();
  PropertyData selectedProperty = PropertyData();

  _onScanQrcode(ScanQrcode event, Emitter<QrState> emit) async {
    emit(QrLoading());
    final qrCode = event.qrCode;
    if (qrCode.isEmpty) {
      emit(const QrError(msg: "Failed to detect Qr Code"));
      return;
    }
    isFromHome = event.isFromHome;
    if (isFromHome) clearPropertyData();

    try {
      this.qrCode = qrCode;
      final resp = await repo.scanQrCode(qrCode: event.qrCode);
      residentData = resp;
      if (!isFromHome) {
        if (residentData.unitNumber != selectedProperty.unitNo) {
          String errMsg =
              "QR diimbas dimiliki oleh unit ${residentData.unitNumber} yang tidak sama seperti yang dipilih";
          emit(QrNotTally(msg: errMsg));
          return;
        }
      }

      emit(QrSuccess(data: residentData));
    } catch (e) {
      log.logError(tag: '_onScanQrcode', msg: e.toString());
      if (e.toString().toLowerCase().contains("not found")) {
        emit(QrNotFound(msg: e.toString()));
      } else {
        emit(QrError(msg: e.toString()));
      }
    } finally {
      EasyLoading.dismiss();
    }
  }

  _onRegisterQrcode(RegisterQrcode event, Emitter<QrState> emit) async {
    if (selectedProperty.unitCode == null ||
        (selectedProperty.unitCode?.isEmpty ?? true)) {
      emit(const QrRegError(msg: "Sila pilih unit rumah"));
      return;
    }

    emit(QrRegLoading());
    try {
      final resp = await repo.registerQrCode(
          qrCode: qrCode, unitCode: selectedProperty.unitCode ?? "");
      if (resp) {
        emit(QrRegSuccess());
      } else {
        emit(const QrRegError(msg: "Something went wrong"));
      }
    } catch (e) {
      String errMsg = e.toString().toLowerCase();
      log.logError(tag: "QrRegister", msg: errMsg);
      if (errMsg.contains("true")) {
        if (errMsg.contains("qrcoderegistered")) {
          emit(const QrRegError(
              msg: "Kod QR ini telah didaftarkan ke unit lain"));
          return;
        }
        add(UpdateQrcode());
      } else {
        emit(QrRegError(msg: e.toString()));
      }
    }
  }

  _onUpdateQrcode(UpdateQrcode event, Emitter<QrState> emit) async {
    emit(QrRegLoading());
    try {
      final resp = await repo.updateQrCode(
          qrCode: qrCode, unitCode: selectedProperty.unitCode ?? "");
      if (resp) {
        emit(QrRegSuccess());
      } else {
        emit(const QrRegError(msg: "Something went wrong"));
      }
    } catch (e) {
      log.logError(tag: "QrUpdate", msg: e.toString());
      emit(QrRegError(msg: e.toString()));
    }
  }

  setPropertyData(
      {ZoneData? selectedZone,
      AreaData? selectedArea,
      BlockData? selectedBlock,
      FloorData? selectedFloor,
      PropertyData? selectedProperty}) {
    this.selectedZone = selectedZone ?? this.selectedZone;
    this.selectedArea = selectedArea ?? this.selectedArea;
    this.selectedBlock = selectedBlock ?? this.selectedBlock;
    this.selectedFloor = selectedFloor ?? this.selectedFloor;
    this.selectedProperty = selectedProperty ?? this.selectedProperty;
  }

  clearPropertyData() {
    selectedProperty = PropertyData();
    selectedZone = ZoneData();
    selectedArea = AreaData();
    selectedBlock = BlockData();
    selectedFloor = FloorData();
  }
}
