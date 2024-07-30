import 'package:eperumahan_bancian/components/custom_navbar.dart';
import 'package:eperumahan_bancian/data/hive-manager/repository/qr_navigation_pref.dart';
import 'package:eperumahan_bancian/screens/login/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../components/custom_alertdialog.dart';
import '../config/routes/routes_name.dart';
import '../services/flushbar/custom_flushbar.dart';
import 'navbar_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

PageController homePageController = PageController();

moveScreenTo(int index) {
  homePageController.animateToPage(index,
      duration: const Duration(milliseconds: 300), curve: Curves.linear);
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onPageChanged(int page) {
    setState(() {
      setQRScannerFromHome(page);
      _selectedIndex = page;
    });
  }

  void setQRScannerFromHome(int page) {
    if (page != 1) return;
    QrNavigationPref.setFromHome(val: true);
  }

  void _onItemTapped(int index) {
    homePageController.jumpToPage(index);
    // homePageController.animateToPage(
    //   index,
    //   duration: const Duration(milliseconds: 300),
    //   curve: Curves.easeInOut,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        await _showLogoutAlert();
      },
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLogoutLoading) {
            EasyLoading.show();
          } else if (state is AuthLogoutSuccess) {
            EasyLoading.dismiss().then(
              (val) => Navigator.popUntil(
                  context, ModalRoute.withName(RoutesName.login)),
            );
          } else if (state is AuthLogoutError) {
            EasyLoading.dismiss();
            Navigator.pop(context);
            CustomFlushbar.of(context).showFailed(msg: state.msg);
          }
        },
        child: Scaffold(
          body: PageView(
            controller: homePageController,
            onPageChanged: _onPageChanged,
            children: List.generate(BottomNavItem.values.length,
                (index) => BottomNavItem.values[index].screen),
          ),
          bottomNavigationBar:
              CustomBottomNav(itemCount: BottomNavItem.values.length, (index) {
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
            onColorBtn: () => context.read<AuthBloc>().add(UserLogout()))
        .show(context);
  }
}
