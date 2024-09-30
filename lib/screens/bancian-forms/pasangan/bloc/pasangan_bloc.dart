import 'package:eperumahan_bancian/screens/bancian-forms/models/spouse_input_model.dart';
import 'package:eperumahan_bancian/services/app_log.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../qr-home/models/resident_info_model.dart';

part 'pasangan_event.dart';
part 'pasangan_state.dart';

class PasanganBloc extends Bloc<PasanganEvent, PasanganState> {
  PasanganBloc() : super(PasanganInitial()) {
    on<SetPasanganData>(_onSetPasanganData);
  }
  final applog = const AppLog(classname: "PasanganBloc");
  ResidentInfoData unitData = ResidentInfoData();
  List<SpouseInputModel> existData = [];
  _onSetPasanganData(SetPasanganData event, Emitter<PasanganState> emit) {
    unitData = event.data;
    existData.clear();
    final data = unitData.toListSpouseJson();
    if (data.isNotEmpty) {
      existData.addAll(data.map((e) => SpouseInputModel.fromJson(e)).toList());
    }
    emit(PasanganLoaded(spouseData: existData));
  }
}
