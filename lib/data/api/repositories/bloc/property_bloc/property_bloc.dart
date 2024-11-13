import 'package:eperumahan_bancian/data/api/repositories/model/property_model.dart';
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
    on<FetchAllArea>(_onFetchAllArea);
    on<FetchBlock>(_onFetchBlock);
    on<FetchUnitFloor>(_onFetchUnitFloor);
    on<FetchListProperties>(_onFetchListProperties);
    on<ChangePropertyFloor>(_onChangePropertyFloor);
    on<FetchFloorAndUnit>(_onFetchFloorAndUnit);
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
  //Property Unit
  List<PropertyData> listProperty = [];
  PropertyData selectedProperty = PropertyData();

  final repo = PropertyRepository();
  final applog = const AppLog(classname: "PropertyBloc");

  _onFetchZone(FetchZone event, Emitter<PropertyState> emit) async {
    emit(PropertyInitial());
    _clearAllData();
    if (listZone.isNotEmpty) {
      return;
    }
    EasyLoading.show();

    try {
      final resp = await repo.fetchZone();
      listZone = resp;
    } catch (e) {
      applog.logError(tag: "fetchZone", msg: e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  _onFetchArea(FetchArea event, Emitter<PropertyState> emit) async {
    EasyLoading.show();
    _clearArea();
    selectedZone = event.zoneData;
    try {
      final resp = await repo.fetchArea(zoneCode: selectedZone.code!);
      listArea = resp;
    } catch (e) {
      applog.logError(tag: "fetchArea", msg: e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  _onFetchAllArea(FetchAllArea event, Emitter<PropertyState> emit) async {
    emit(PropertyInitial());
    _clearArea();
    EasyLoading.show();
    //Fetch zone because user dont have to choose it
    if (listZone.isEmpty) {
      try {
        final resp = await repo.fetchZone();
        listZone = resp;
      } catch (e) {
        applog.logError(tag: "fetchZone", msg: e.toString());
      }
    }

    if (listArea.isNotEmpty) {
      return;
    }

    try {
      final resp = await repo.fetchArea(zoneCode: "");
      listArea = resp;
    } catch (e) {
      applog.logError(tag: "fetchArea", msg: e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  _onFetchBlock(FetchBlock event, Emitter<PropertyState> emit) async {
    EasyLoading.show();
    _clearBlock();
    selectedArea = event.areaData;
    selectedZone = listZone.firstWhere(
        (val) => (val.code ?? ":(") == (selectedArea.zone?.code ?? ":)"));
    try {
      final resp = await repo.fetchBlock(housingCode: selectedArea.code!);
      listBlock = resp;
    } catch (e) {
      applog.logError(tag: "fetchBlock", msg: e.toString());
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
      applog.logError(tag: "fetchUnitFloor", msg: e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  _onFetchListProperties(
      FetchListProperties event, Emitter<PropertyState> emit) async {
    emit(PropertyLoading());
    try {
      if (selectedZone.code == null ||
          selectedArea.code == null ||
          selectedBlock.blockNo == null) {
        emit(const PropertyError(msg: "Please select all data"));
        return;
      }

      if (listFloor.isNotEmpty) {
        selectedFloor = listFloor.first;
      }

      final resp = await repo.fetchListProperties(
          zoneCode: selectedZone.code ?? "",
          housingCode: selectedArea.code!,
          blockNo: selectedBlock.blockNo.toString(),
          floor: selectedFloor.floorNo ?? "");
      listProperty = resp;
      emit(PropertySuccess());
    } catch (e) {
      applog.logError(tag: "fetchListProperties", msg: e.toString());
      emit(PropertyError(msg: e.toString()));
    }
  }

  _onChangePropertyFloor(
      ChangePropertyFloor event, Emitter<PropertyState> emit) async {
    emit(UnitLoading());
    try {
      selectedFloor = event.floorData;
      final resp = await repo.fetchListProperties(
          zoneCode: selectedZone.code ?? "",
          housingCode: selectedArea.code!,
          blockNo: selectedBlock.blockNo.toString(),
          floor: selectedFloor.floorNo.toString());
      listProperty = resp;
      emit(UnitSuccess());
    } catch (e) {
      applog.logError(tag: "fetchListProperties", msg: e.toString());
      emit(UnitError(msg: e.toString()));
    }
  }

  _onFetchFloorAndUnit(
      FetchFloorAndUnit event, Emitter<PropertyState> emit) async {
    emit(PropertyLoading());
    selectedBlock = event.blockData;
    try {
      final resp = await repo.fetchUnitFloor(
          housingCode: selectedArea.code!,
          blockNo: selectedBlock.blockNo.toString());
      listFloor = resp;
    } catch (e) {
      applog.logError(tag: "onFetchFloorAndUnit 1", msg: e.toString());
      emit(PropertyError(msg: e.toString()));
      return;
    }

    try {
      if (selectedZone.code == null ||
          selectedArea.code == null ||
          selectedBlock.blockNo == null) {
        emit(const PropertyError(msg: "Please select all data"));
        return;
      }

      if (listFloor.isNotEmpty) {
        selectedFloor = listFloor.first;
      }

      final resp = await repo.fetchListProperties(
          zoneCode: selectedZone.code ?? "",
          housingCode: selectedArea.code!,
          blockNo: selectedBlock.blockNo.toString(),
          floor: selectedFloor.floorNo ?? "");
      listProperty = resp;
      emit(PropertySuccess());
    } catch (e) {
      applog.logError(tag: "onFetchFloorAndUnit 2", msg: e.toString());
      emit(PropertyError(msg: e.toString()));
    }
  }

  _clearAllData() {
    listArea.clear();
    listBlock.clear();
    listFloor.clear();
    listProperty.clear();
    selectedZone = ZoneData();
    selectedArea = AreaData();
    selectedBlock = BlockData();
    selectedFloor = FloorData();
    selectedProperty = PropertyData();
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
