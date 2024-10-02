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
  }
  String censusCode = "";
  ResidentInfoData unitData = ResidentInfoData();
  OwnerInputModel? existData;
  final repo = ApplicationRepository();
  final applog = const AppLog(classname: "PenghuniBloc");
  _onSetPenghuniData(SetPenghuniData event, Emitter<PenghuniState> emit) {
    unitData = event.data;
    existData = null;
    existData = OwnerInputModel.fromJson(unitData.toOwnerJson());
    censusCode = event.censusCode;
    applog.logDebug(
        tag: "_onSetPenghuniData",
        msg: existData?.toJson().toString() ?? "No data");
  }

  _onSavePenghuniData(
      SavePenghuniData event, Emitter<PenghuniState> emit) async {
    emit(PenghuniLoading());
    applog.logDebug(tag: "Send Item", msg: event.data.toJson().toString());
    try {
      final resp = await repo.storeOwner(data: event.data);
      applog.logDebug(tag: "_onSavePenghuniData", msg: resp);
      existData = event.data;
      emit(PenghuniSuccess());
    } catch (e) {
      applog.logError(tag: "_onSavePenghuniData", msg: e.toString());
      emit(PenghuniError(msg: e.toString()));
    } finally {
      EasyLoading.dismiss();
    }
  }
}
