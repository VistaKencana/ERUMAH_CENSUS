import 'package:eperumahan_bancian/components/custom_navbar.dart';
import 'package:eperumahan_bancian/data/api/repositories/bloc/home_provider.dart';
import 'package:eperumahan_bancian/screens/login/bloc/auth_bloc.dart';
import 'package:eperumahan_bancian/services/flushbar/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../components/custom_alertdialog.dart';
import '../config/routes/routes_name.dart';
import 'navbar_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeProvider _homeProvider;
  @override
  void initState() {
    super.initState();
    _homeProvider = context.read<HomeProvider>();
    _homeProvider.initHome();
  }

  @override
  void dispose() {
    _homeProvider.disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeProviderWatch = context.watch<HomeProvider>();
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        await _showLogoutAlert();
      },
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLogoutLoading) {
            EasyLoading.show();
          } else if (state is AuthLogoutSuccess) {
            EasyLoading.dismiss().then(
              (val) => Navigator.pushNamedAndRemoveUntil(
                // ignore: use_build_context_synchronously
                context,
                RoutesName.login,
                (route) => false,
              ),
            );
          } else if (state is AuthLogoutError) {
            EasyLoading.dismiss();
            Navigator.pop(context);
            CustomFlushbar.of(context).showFailed(msg: state.msg);
          }
        },
        child: Scaffold(
          body: PageView(
            controller: _homeProvider.pageController,
            onPageChanged: _homeProvider.onPageChanged,
            children: List.generate(BottomNavItem.values.length,
                (index) => BottomNavItem.values[index].screen),
          ),
          bottomNavigationBar:
              CustomBottomNav(itemCount: BottomNavItem.values.length, (index) {
            final data = BottomNavItem.values[index];
            return NavItem(
              itemCount: BottomNavItem.values.length,
              onTap: () => _homeProvider.onItemTapped(index),
              icon: homeProviderWatch.currentIndex == index
                  ? data.item.activeIcon
                  : data.item.icon,
              isSelected: homeProviderWatch.currentIndex == index,
              label: data.item.label!,
            );
          }),
        ),
      ),
    );
  }

  Future _showLogoutAlert() async {
    return await CustomAlertDialog(
      position: AlertBtnPosition.leftRignt,
      title: "Logout",
      subtitle: "You will be logout from this app",
      colorBtnLabel: "Logout",
      dimmedBtnLabel: "Cancel",
      onDimmedBtn: () => Navigator.pop(context),
      onColorBtn: () => context.read<AuthBloc>().add(UserLogout()),
      // Navigator.popUntil(context, ModalRoute.withName(RoutesName.login)),
    ).show(context);
  }
}
