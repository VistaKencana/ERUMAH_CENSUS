import 'package:eperumahan_bancian/data/hive-manager/hive_manager.dart';

class QrNavigationPref {
  static const String _qrNavKey = "QrNav";
  static final qrNavPref = HiveBoxPreference<bool>(key: _qrNavKey);

  static Future<bool> isFromHome() async {
    final data = qrNavPref.getData();
    if (data == null) {
      await qrNavPref.saveData(value: false);
      return false;
    }
    return data;
  }

  static Future<void> setFromHome({required bool val}) async {
    await qrNavPref.saveData(value: val);
  }
}
