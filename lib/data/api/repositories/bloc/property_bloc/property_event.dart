part of 'property_bloc.dart';

sealed class PropertyEvent extends Equatable {
  const PropertyEvent();

  @override
  List<Object> get props => [];
}

class FetchZone extends PropertyEvent {}

class FetchArea extends PropertyEvent {
  final ZoneData zoneData;

  const FetchArea({required this.zoneData});
}

class FetchAllArea extends PropertyEvent {}

class FetchBlock extends PropertyEvent {
  final AreaData areaData;

  const FetchBlock({required this.areaData});
}

class FetchUnitFloor extends PropertyEvent {
  final BlockData blockData;

  const FetchUnitFloor({required this.blockData});
}

class FetchListProperties extends PropertyEvent {
  const FetchListProperties();
}

class ChangePropertyFloor extends PropertyEvent {
  final FloorData floorData;

  const ChangePropertyFloor({required this.floorData});
}

class FetchFloorAndUnit extends PropertyEvent {
  final BlockData blockData;

  const FetchFloorAndUnit({required this.blockData});
}
