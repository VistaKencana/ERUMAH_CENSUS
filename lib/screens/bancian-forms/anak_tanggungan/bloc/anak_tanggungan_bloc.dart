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
    unitData = event.data;

    existChild.clear();
    final data = unitData.toDependantChildJson();
    if (data.isNotEmpty) {
      data.map((e) => existChild.add(DependantInputModel.fromJson(e)));
    }

    existOthers.clear();
    final data2 = unitData.toDependantOtherJson();
    if (data2.isNotEmpty) {
      data2.map((e) => existOthers.add(DependantInputModel.fromJson(e)));
    }
  }
}
