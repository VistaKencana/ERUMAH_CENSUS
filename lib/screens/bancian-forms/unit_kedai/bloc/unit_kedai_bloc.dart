import 'package:eperumahan_bancian/data/api/repositories/application_repository.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/models/unit_kedai_input_model.dart';
import 'package:eperumahan_bancian/screens/qr-home/models/resident_info_model.dart';
import 'package:eperumahan_bancian/services/app_log.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

part 'unit_kedai_event.dart';
part 'unit_kedai_state.dart';

class UnitKedaiBloc extends Bloc<UnitKedaiEvent, UnitKedaiState> {
  UnitKedaiBloc() : super(UnitKedaiInitial()) {
    on<SetPemilikData>(_onSetPemilikData);
    on<SavePemilikData>(_onSavePenghuniData);
  }
  ResidentInfoData unitData = ResidentInfoData();
  UnitKedaiInputModel? _existData;
  final repo = ApplicationRepository();
  final applog = const AppLog(classname: "UnitKedaiBloc");
  String censusCode = "";

  UnitKedaiInputModel get existData {
    return _existData ?? UnitKedaiInputModel();
  }

  void _onSetPemilikData(SetPemilikData event, Emitter<UnitKedaiState> emit) {
    try {
      unitData = event.data;
      //[Owner] Setting current model
      _existData = null;
      _existData = UnitKedaiInputModel.fromJson(unitData.toUnitKedaiJson());
      censusCode = event.censusCode;
      //[Not Owner] Setting  model
      // _notOwnerData = OwnerInputModel(
      //     censusCode: event.censusCode, isNotOwner: "1", totalHousehold: "0");
      applog.logDebug(
          tag: "_onSetPemilikData",
          msg: _existData?.toJson().toString() ?? "No data");
    } catch (e) {
      applog.logError(tag: "_onSetPemilikData", msg: e.toString());
    }
  }

  Future<void> _onSavePenghuniData(
      SavePemilikData event, Emitter<UnitKedaiState> emit) async {
    //Validate if there is changes
    var origin =
        _existData!.copyWith(isChangeOnImage: false).toValidate().toString();
    var newData = event.data.toValidate().toString();
    if (origin.contains(newData)) {
      emit(const UnitKedaiNoChanges(msg: "Tiada Perubahan Dibuat"));
      emit(UnitKedaiInitial());
      return;
    }
    //Start call API
    emit(UnitKedaiLoading());
    applog.logDebug(tag: "Send Item", msg: event.data.toJson().toString());
    try {
      final resp = await repo.storeShop(data: event.data);
      applog.logDebug(tag: "_onSaveUnitKedaiData", msg: resp);
      _existData = event.data;
      emit(UnitKedaiSuccess());
    } catch (e) {
      applog.logError(tag: "_onSaveUnitKedaiData", msg: e.toString());
      emit(UnitKedaiError(msg: e.toString()));
    } finally {
      EasyLoading.dismiss();
    }
  }
}
