import 'dart:typed_data';

import 'package:eperumahan_bancian/screens/bancian-forms/models/status_input_model.dart';
import 'package:eperumahan_bancian/screens/qr-home/models/resident_info_model.dart';
import 'package:eperumahan_bancian/services/app_log.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bancian_event.dart';
part 'bancian_state.dart';

class BancianBloc extends Bloc<BancianEvent, BancianState> {
  BancianBloc() : super(BancianInitial()) {
    on<SetBancianData>(_onSetBancianData);
  }
  final applog = const AppLog(classname: "BancianBloc");
  ResidentInfoData unitData = ResidentInfoData();
  StatusInputModel? statusData;
  _onSetBancianData(SetBancianData event, Emitter<BancianState> emit) {
    unitData = event.data;
    statusData = StatusInputModel(
        censusCode: unitData.censusCode ?? '',
        isFingerPrintVerified: "0",
        statusCode: "",
        email: "",
        remark: "");
  }

  setImages({required List<Uint8List> imgs}) {
    statusData = statusData!.copyWith(images: imgs);
  }
}
