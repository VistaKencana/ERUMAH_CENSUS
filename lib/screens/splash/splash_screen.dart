import 'package:eperumahan_bancian/config/routes/routes_name.dart';
import 'package:eperumahan_bancian/data/hive-manager/repository/login_pref.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1500), () {
      final isLoggedIn = LoginPreference().isTokenExpired() != null;
      Navigator.pushNamedAndRemoveUntil(
          context, RoutesName.login, (route) => false);
      if (isLoggedIn) {
        Navigator.pushNamed(context, RoutesName.home);
      }
    });

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
