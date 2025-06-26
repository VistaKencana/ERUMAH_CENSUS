import 'package:eperumahan_bancian/data/api/repositories/model/area_model.dart';
import 'package:eperumahan_bancian/data/api/repositories/model/block_model.dart';
import 'package:eperumahan_bancian/data/api/repositories/model/zone_model.dart';
import 'package:eperumahan_bancian/data/hive-manager/repository/qr_navigation_pref.dart';
import 'package:eperumahan_bancian/data/hive-manager/repository/recent_search_pref.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  late PageController pageController;
  int currentIndex = 0;
  List<RecentModel> _recentList = [];
  List<RecentModel> get recentList => _recentList;
  bool get isRecentEmpty => _recentList.isEmpty;
  void initHome() {
    currentIndex = 0;
    pageController = PageController(initialPage: currentIndex);
  }

  void disposeController() {
    pageController.dispose();
  }

  void moveScreenTo(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
    notifyListeners();
  }

  void onItemTapped(int index) {
    pageController.jumpToPage(index);
    notifyListeners();
  }

  void onPageChanged(int page) {
    setQRScannerFromHome(page);
    currentIndex = page;
    notifyListeners();
  }

  void setQRScannerFromHome(int page) {
    QrNavigationPref.setFromHome(val: (page == 1));
    notifyListeners();
  }

  void fetchRecent() {
    _recentList = RecentSearchPref.getSearchData();
    notifyListeners();
  }

  void saveRecent({
    required ZoneData zoneCode,
    required AreaData housingCode,
    required BlockData blockNo,
  }) async {
    RecentSearchPref.saveSearchData(
        zoneCode: zoneCode, housingCode: housingCode, blockNo: blockNo);
    await Future.delayed(Durations.medium4);
    fetchRecent();
    notifyListeners();
  }
}
