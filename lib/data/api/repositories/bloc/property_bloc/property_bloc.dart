import 'package:eperumahan_bancian/data/api/repositories/property_repository.dart';
import 'package:eperumahan_bancian/services/app_log.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../model/area_model.dart';
import '../../model/block_model.dart';
import '../../model/floor_model.dart';
import '../../model/zone_model.dart';

part 'property_event.dart';
part 'property_state.dart';

class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  PropertyBloc() : super(PropertyInitial()) {
    on<FetchZone>(_onFetchZone);
    on<FetchArea>(_onFetchArea);
    on<FetchBlock>(_onFetchBlock);
    on<FetchUnitFloor>(_onFetchUnitFloor);
  }

  //Zone
  List<ZoneData> listZone = [];
  ZoneData selectedZone = ZoneData();
  //Area
  List<AreaData> listArea = [];
  AreaData selectedArea = AreaData();
  //Block
  List<BlockData> listBlock = [];
  BlockData selectedBlock = BlockData();
  //Floor
  List<FloorData> listFloor = [];
  FloorData selectedFloor = FloorData();

  final repo = PropertyRepository();
  final applog = const AppLog(classname: "PropertyBloc");
  _onFetchZone(FetchZone event, Emitter<PropertyState> emit) async {
    EasyLoading.show();
    _clearAllData();
    try {
      final resp = await repo.fetchZone();
      listZone = resp;
    } catch (e) {
      applog.log(tag: "fetchZone", msg: e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  _onFetchArea(FetchArea event, Emitter<PropertyState> emit) async {
    EasyLoading.show();
    _clearArea();
    selectedZone = event.zoneData;
    try {
      final resp = await repo.fetchArea(zoneCode: selectedZone.zoneCode!);
      listArea = resp;
    } catch (e) {
      applog.log(tag: "fetchArea", msg: e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  _onFetchBlock(FetchBlock event, Emitter<PropertyState> emit) async {
    EasyLoading.show();
    _clearBlock();
    selectedArea = event.areaData;
    try {
      final resp = await repo.fetchBlock(housingCode: selectedArea.code!);
      listBlock = resp;
    } catch (e) {
      applog.log(tag: "fetchBlock", msg: e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  _onFetchUnitFloor(FetchUnitFloor event, Emitter<PropertyState> emit) async {
    EasyLoading.show();
    selectedBlock = event.blockData;
    try {
      final resp = await repo.fetchUnitFloor(
          housingCode: selectedArea.code!,
          blockNo: selectedBlock.blockNo.toString());
      listFloor = resp;
    } catch (e) {
      applog.log(tag: "fetchUnitFloor", msg: e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  _clearAllData() {
    listZone.clear();
    listArea.clear();
    listBlock.clear();
    listFloor.clear();
    selectedZone = ZoneData();
    selectedArea = AreaData();
    selectedBlock = BlockData();
    selectedFloor = FloorData();
  }

  _clearArea() {
    listArea.clear();
    listBlock.clear();
    listFloor.clear();

    selectedArea = AreaData();
    selectedBlock = BlockData();
    selectedFloor = FloorData();
  }

  _clearBlock() {
    listBlock.clear();
    listFloor.clear();

    selectedBlock = BlockData();
    selectedFloor = FloorData();
  }
}
