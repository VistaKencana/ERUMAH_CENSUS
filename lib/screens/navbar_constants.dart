import 'package:eperumahan_bancian/screens/activity/activity_screen.dart';
import 'package:eperumahan_bancian/screens/qr-home/qrscan_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dashboard/dashboard_screen.dart';
import 'profile/profile_screen.dart';

enum BottomNavItem {
  home(
    screen: DashboardScreen(),
    item: BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.dashcube, color: Colors.black54),
      // icon: Icon(Icons.dashboard_outlined, color: Colors.white),
      activeIcon: FaIcon(FontAwesomeIcons.dashcube, color: Color(0xFF8D182D)),
      // activeIcon: CustomShader.btmNavBar(icon: Icon(Icons.home)),
      label: 'Dashboard',
    ),
  ),
  qrscan(
    screen: QrScanScreen(),
    item: BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.qrcode, color: Colors.black54),
      activeIcon: FaIcon(FontAwesomeIcons.qrcode, color: Color(0xFF8D182D)),
      // activeIcon: CustomShader.btmNavBar(icon: Icon(Icons.mail)),
      label: 'QR Scan',
    ),
  ),
  activity(
    screen: ActivityScreen(),
    item: BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.magnifyingGlass, color: Colors.black54),
      activeIcon:
          FaIcon(FontAwesomeIcons.magnifyingGlass, color: Color(0xFF8D182D)),
      // activeIcon: CustomShader.btmNavBar(icon: Icon(Icons.mail)),
      label: 'Activity',
    ),
  ),
  profile(
    screen: ProfileScreen(),
    item: BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.circleUser, color: Colors.black54),
      activeIcon: FaIcon(FontAwesomeIcons.circleUser, color: Color(0xFF8D182D)),
      // activeIcon: CustomShader.btmNavBar(icon: Icon(Icons.apartment)),
      label: 'Profile',
    ),
  );

  final BottomNavigationBarItem item;
  final Widget screen;

  const BottomNavItem({required this.item, required this.screen});
}
