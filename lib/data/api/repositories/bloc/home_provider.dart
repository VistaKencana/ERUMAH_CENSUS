import 'package:eperumahan_bancian/data/hive-manager/repository/qr_navigation_pref.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  late PageController pageController;
  int currentIndex = 0;
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
    if (page != 1) return;
    QrNavigationPref.setFromHome(val: true);
    notifyListeners();
  }
}
