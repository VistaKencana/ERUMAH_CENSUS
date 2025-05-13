import 'package:eperumahan_bancian/config/constants/app_images.dart';
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

    return LayoutBuilder(builder: (contex, constraint) {
      return Scaffold(
          body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            stops: [0.0, 0.23, 0.61, 1.0],
            colors: [
              Color(0xFFBA2C45), // 0%
              Color(0xFF641725), // 23%
              Color(0xFF50121D), // 61%
              Color(0xFF040001), // 100%
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 30 / 9,
                child: Image.asset(
                  AppImages.dbklLogo.path,
                  fit: BoxFit.contain,
                  height: constraint.maxHeight * .2,
                  width: constraint.maxWidth * .4,
                ),
              ),
              const SizedBox(height: 30),
              const CircularProgressIndicator(color: Colors.white)
            ],
          ),
        ),
      ));
    });
  }
}
