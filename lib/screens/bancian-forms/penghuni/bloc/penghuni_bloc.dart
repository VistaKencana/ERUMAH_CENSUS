import 'package:eperumahan_bancian/data/api/repositories/application_repository.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/models/owner_input_model.dart';
import 'package:eperumahan_bancian/services/app_log.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../qr-home/models/resident_info_model.dart';

part 'penghuni_event.dart';
part 'penghuni_state.dart';

class PenghuniBloc extends Bloc<PenghuniEvent, PenghuniState> {
  PenghuniBloc() : super(PenghuniInitial()) {
    on<SetPenghuniData>(_onSetPenghuniData);
    on<SavePenghuniData>(_onSavePenghuniData);
    on<SaveBukanPenghuniData>(_onSaveBukanPenghuniData);
  }
  String censusCode = "";
  ResidentInfoData unitData = ResidentInfoData();
  OwnerInputModel? _existData;
  OwnerInputModel? _notOwnerData;
  final repo = ApplicationRepository();
  final applog = const AppLog(classname: "PenghuniBloc");

  OwnerInputModel get existData {
    return _existData ?? OwnerInputModel();
  }

  OwnerInputModel get notOwnerData {
    return _notOwnerData ?? OwnerInputModel();
  }

  void _onSetPenghuniData(SetPenghuniData event, Emitter<PenghuniState> emit) {
    try {
      unitData = event.data;
      //[Owner] Setting current model
      _existData = null;
      _existData = OwnerInputModel.fromJson(unitData.toOwnerJson());
      censusCode = event.censusCode;
      //[Not Owner] Setting  model
      _notOwnerData = OwnerInputModel(
          censusCode: event.censusCode, isNotOwner: "1", totalHousehold: "0");
      applog.logDebug(
          tag: "_onSetPenghuniData",
          msg: _existData?.toJson().toString() ?? "No data");
    } catch (e) {
      applog.logError(tag: "_onSetPenghuniData", msg: e.toString());
    }
  }

  Future<void> _onSavePenghuniData(
      SavePenghuniData event, Emitter<PenghuniState> emit) async {
    //Validate if there is changes
    var origin =
        _existData!.copyWith(isChangeOnImage: false).toValidate().toString();
    var newData = event.data.toValidate().toString();
    if (origin.contains(newData)) {
      emit(const PenghuniNoChanges(msg: "Tiada Perubahan Dibuat"));
      emit(PenghuniInitial());
      return;
    }
    //Start call API
    emit(PenghuniLoading());
    applog.logDebug(tag: "Send Item", msg: event.data.toJson().toString());
    try {
      final resp = await repo.storeOwner(data: event.data);
      applog.logDebug(tag: "_onSavePenghuniData", msg: resp);
      _existData = event.data;
      emit(PenghuniSuccess());
    } catch (e) {
      applog.logError(tag: "_onSavePenghuniData", msg: e.toString());
      emit(PenghuniError(msg: e.toString()));
    } finally {
      EasyLoading.dismiss();
    }
  }

  bool isNotOwnerisFilled() {
    return _notOwnerData?.name?.isNotEmpty ?? false;
  }

  Future<void> _onSaveBukanPenghuniData(
      SaveBukanPenghuniData event, Emitter<PenghuniState> emit) async {
    //Validate if there is changes
    var origin =
        _notOwnerData!.copyWith(isChangeOnImage: false).toValidate().toString();
    var newData = event.data.toValidate().toString();
    if (origin.contains(newData)) {
      emit(const PenghuniNoChanges(msg: "Tiada Perubahan Dibuat"));
      emit(PenghuniInitial());
      return;
    }

    //Start call API
    emit(PenghuniLoading());
    applog.logDebug(tag: "Send Item", msg: event.data.toJson().toString());
    try {
      final resp = await repo.storeNotOwner(data: event.data);
      applog.logDebug(tag: "_onSaveBukanPenghuniData", msg: resp);
      _notOwnerData = event.data;
      emit(PenghuniSuccess());
    } catch (e) {
      applog.logError(tag: "_onSaveBukanPenghuniData", msg: e.toString());
      emit(PenghuniError(msg: e.toString()));
    } finally {
      EasyLoading.dismiss();
    }
  }
}
