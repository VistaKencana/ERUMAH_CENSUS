import 'package:eperumahan_bancian/components/custom_navbar.dart';
import 'package:flutter/material.dart';

import '../components/custom_alertdialog.dart';
import '../config/routes/routes_name.dart';
import 'navbar_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _onPageChanged(int page) {
    setState(() {
      _selectedIndex = page;
    });
  }

  void _onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        await _showLogoutAlert();
      },
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: List.generate(BottomNavItem.values.length,
              (index) => BottomNavItem.values[index].screen),
        ),
        bottomNavigationBar: CustomBottomNav(itemCount: 3, (index) {
          final data = BottomNavItem.values[index];
          return NavItem(
            itemCount: BottomNavItem.values.length,
            onTap: () => _onItemTapped(index),
            icon: data.item.icon,
            isSelected: _selectedIndex == index,
            label: data.item.label!,
          );
        }),
      ),
    );
  }

  _showLogoutAlert() async {
    return await CustomAlertDialog(
      position: AlertBtnPosition.leftRignt,
      title: "Logout",
      subtitle: "You will be logout from this app",
      colorBtnLabel: "Logout",
      dimmedBtnLabel: "Cancel",
      onDimmedBtn: () => Navigator.pop(context),
      onColorBtn: () =>
          Navigator.popUntil(context, ModalRoute.withName(RoutesName.login)),
    ).show(context);
  }
}
