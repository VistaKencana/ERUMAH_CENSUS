import 'package:eperumahan_bancian/screens/bancian-forms/models/owner_input_model.dart';
import 'package:eperumahan_bancian/services/app_log.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../qr-home/models/resident_info_model.dart';

part 'penghuni_event.dart';
part 'penghuni_state.dart';

class PenghuniBloc extends Bloc<PenghuniEvent, PenghuniState> {
  PenghuniBloc() : super(PenghuniInitial()) {
    on<SetPenghuniData>(_onSetPenghuniData);
  }
  ResidentInfoData unitData = ResidentInfoData();
  OwnerInputModel? existData;
  final applog = const AppLog(classname: "PenghuniBloc");
  _onSetPenghuniData(SetPenghuniData event, Emitter<PenghuniState> emit) {
    unitData = event.data;
    existData = null;
    existData = OwnerInputModel.fromJson(unitData.toOwnerJson());
    applog.logDebug(
        tag: "_onSetPenghuniData",
        msg: existData?.toJson().toString() ?? "No data");
  }
}
