import 'package:eperumahan_bancian/screens/activity/activity_screen.dart';
import 'package:eperumahan_bancian/screens/qr-home/qrscan_screen.dart';
import 'package:flutter/material.dart';
import 'dashboard/dashboard_screen.dart';
import 'profile/profile_screen.dart';

enum BottomNavItem {
  home(
    screen: DashboardScreen(),
    item: BottomNavigationBarItem(
      icon: Icon(Icons.dashboard_outlined, color: Colors.white),
      // activeIcon: CustomShader.btmNavBar(icon: Icon(Icons.home)),
      label: 'Dashboard',
    ),
  ),
  qrscan(
    screen: QrScanScreen(),
    item: BottomNavigationBarItem(
      icon: Icon(Icons.qr_code_scanner_outlined, color: Colors.white),
      // activeIcon: CustomShader.btmNavBar(icon: Icon(Icons.mail)),
      label: 'QR Scan',
    ),
  ),
  activity(
    screen: ActivityScreen(),
    item: BottomNavigationBarItem(
      icon: Icon(Icons.list, color: Colors.white),
      // activeIcon: CustomShader.btmNavBar(icon: Icon(Icons.mail)),
      label: 'Activity',
    ),
  ),
  profile(
    screen: ProfileScreen(),
    item: BottomNavigationBarItem(
      icon: Icon(Icons.person_outline, color: Colors.white),
      // activeIcon: CustomShader.btmNavBar(icon: Icon(Icons.apartment)),
      label: 'Profile',
    ),
  );

  final BottomNavigationBarItem item;
  final Widget screen;

  const BottomNavItem({required this.item, required this.screen});
}
