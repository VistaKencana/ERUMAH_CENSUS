import 'package:eperumahan_bancian/screens/bancian-forms/models/dependant_input_model.dart';
import 'package:eperumahan_bancian/screens/qr-home/models/resident_info_model.dart';
import 'package:eperumahan_bancian/services/app_log.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'anak_tanggungan_event.dart';
part 'anak_tanggungan_state.dart';

class AnakTanggunganBloc
    extends Bloc<AnakTanggunganEvent, AnakTanggunganState> {
  AnakTanggunganBloc() : super(AnakTanggunganInitial()) {
    on<SetAnakTanggungData>(_onSetAnakTanggungData);
  }
  ResidentInfoData unitData = ResidentInfoData();
  List<DependantInputModel> existChild = [];
  List<DependantInputModel> existOthers = [];
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
      emit(AnakTanggunganLoaded(childData: existChild, otherData: existOthers));
    } catch (e) {
      applog.logError(tag: "_onSetAnakTanggungData", msg: e.toString());
    }
  }
}
