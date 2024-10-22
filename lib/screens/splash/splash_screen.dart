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
          // ignore: use_build_context_synchronously
          context,
          RoutesName.login,
          (route) => false);
      if (isLoggedIn) {
        // ignore: use_build_context_synchronously
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
