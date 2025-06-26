import 'dart:convert';

import 'package:eperumahan_bancian/data/api/repositories/model/area_model.dart';
import 'package:eperumahan_bancian/data/api/repositories/model/block_model.dart';
import 'package:eperumahan_bancian/data/api/repositories/model/zone_model.dart';
import 'package:eperumahan_bancian/data/hive-manager/hive_manager.dart';

class RecentSearchPref {
  static final _searchPref = HiveBoxPreference<String>(key: "recent_data");

  static void saveSearchData({
    required ZoneData zoneCode,
    required AreaData housingCode,
    required BlockData blockNo,
  }) {
    final newData = RecentModel(
      zoneCode: zoneCode,
      housingCode: housingCode,
      blockNo: blockNo,
    );

    List<RecentModel> currData = getSearchData();

    // Remove duplicates
    currData.removeWhere((item) =>
        item.zoneCode.code == zoneCode.code &&
        item.housingCode.code == housingCode.code &&
        item.blockNo.blockNo == blockNo.blockNo);

    // Add new item
    currData.add(newData);

    // Limit to last 4
    if (currData.length > 4) {
      currData = currData.sublist(currData.length - 4);
    }

    // Save as JSON string
    final encoded = jsonEncode(currData.map((e) => e.toMap()).toList());
    _searchPref.saveData(value: encoded);
  }

  static List<RecentModel> getSearchData() {
    final raw = _searchPref.getData();
    if (raw == null) return [];

    try {
      final List decoded = jsonDecode(raw);
      return decoded
          .map((item) => RecentModel.fromMap(Map<String, dynamic>.from(item)))
          .toList()
          .reversed
          .toList();
    } catch (e) {
      return [];
    }
  }

  static Future<void> clear() async {
    await _searchPref.deleteData();
  }
}

class RecentModel {
  ZoneData zoneCode;
  AreaData housingCode;
  BlockData blockNo;

  RecentModel({
    required this.zoneCode,
    required this.housingCode,
    required this.blockNo,
  });

  Map<String, dynamic> toMap() {
    return {
      'zoneCode': zoneCode.toJson(),
      'housingCode': housingCode.toJson(),
      'blockNo': blockNo.toJson(),
    };
  }

  factory RecentModel.fromMap(Map<String, dynamic> map) {
    return RecentModel(
      zoneCode: ZoneData.fromJson(map['zoneCode']),
      housingCode: AreaData.fromJson(map['housingCode']),
      blockNo: BlockData.fromJson(map['blockNo']),
    );
  }
}
