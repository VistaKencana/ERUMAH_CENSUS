import 'package:eperumahan_bancian/config/constants/app_images.dart';
import 'package:eperumahan_bancian/screens/activity/activity_screen.dart';
import 'package:eperumahan_bancian/screens/qr-home/qrscan_screen.dart';
import 'package:flutter/material.dart';
import 'dashboard/dashboard_screen.dart';

enum BottomNavItem {
  home(
    screen: DashboardScreen(),
    iconType: IconType.builtin,
  ),
  qrscan(
    screen: QrScanScreen(),
    iconType: IconType.asset,
  ),
  activity(
    screen: ActivityScreen(),
    iconType: IconType.builtin,
  );

  final Widget screen;
  final IconType iconType;

  const BottomNavItem({
    required this.screen,
    required this.iconType,
  });

  BottomNavigationBarItem get item {
    return BottomNavigationBarItem(
      icon: _buildIcon(active: false),
      activeIcon: _buildIcon(active: true),
      label: _label,
    );
  }

  Widget _buildIcon({required bool active}) {
    switch (this) {
      case BottomNavItem.home:
        return Icon(
          active ? Icons.dashboard : Icons.dashboard_outlined,
          color: Colors.white,
        );
      case BottomNavItem.qrscan:
        return Image.asset(
          AppImages.qrIcons.path,
          width: 45,
          height: 45,
        );
      case BottomNavItem.activity:
        return Icon(
          active ? Icons.search : Icons.search_outlined,
          color: Colors.white,
        );
    }
  }

  String get _label {
    switch (this) {
      case BottomNavItem.home:
        return 'Dashboard';
      case BottomNavItem.qrscan:
        return '';
      case BottomNavItem.activity:
        return 'Activity';
    }
  }
}

enum IconType { builtin, asset }

// enum BottomNavItem {
//   home(
//     screen: DashboardScreen(),
//     item: BottomNavigationBarItem(
//       icon: Icon(Icons.dashboard_outlined, color: Colors.white),
//       activeIcon: Icon(Icons.dashboard, color: Colors.white),
//       // activeIcon: CustomShader.btmNavBar(icon: Icon(Icons.home)),
//       label: 'Dashboard',
//     ),
//   ),
//   qrscan(
//     screen: QrScanScreen(),
//     item: BottomNavigationBarItem(
//       icon: Image.asset("assets/icons/qr.png"),  
//       activeIcon: Icon(Icons.qr_code_scanner_rounded, color: Colors.white),
//       // activeIcon: CustomShader.btmNavBar(icon: Icon(Icons.mail)),
//       label: 'QR Scan',
//     ),
//   ),
//   // activity(
//   //   screen: ActivityScreen(),
//   //   item: BottomNavigationBarItem(
//   //     icon: Icon(Icons.list, color: Colors.white),
//   //     activeIcon: Icon(Icons.list, color: Colors.white),
//   //     // activeIcon: CustomShader.btmNavBar(icon: Icon(Icons.mail)),
//   //     label: 'Activity',
//   //   ),
//   // ),
//   profile(
//     screen: ProfileScreen(),
//     item: BottomNavigationBarItem(
//       icon: Icon(Icons.person_outline, color: Colors.white),
//       activeIcon: Icon(Icons.person, color: Colors.white),
//       // activeIcon: CustomShader.btmNavBar(icon: Icon(Icons.apartment)),
//       label: 'Profile',
//     ),
//   );

//   final BottomNavigationBarItem item;
//   final Widget screen;

//   const BottomNavItem({required this.item, required this.screen});
// }
