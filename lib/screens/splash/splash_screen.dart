import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/config/routes/routes_name.dart';
import 'package:eperumahan_bancian/data/hive-manager/repository/login_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/constants/app_images.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 2000), () {
      final isLoggedIn = LoginPreference().isTokenExpired() != null;
      Navigator.pushNamedAndRemoveUntil(
          context, RoutesName.landing, (route) => false);
      if (isLoggedIn) {
        Navigator.pushNamed(context, RoutesName.login);
        Navigator.pushNamed(context, RoutesName.home);
      }
    });

    return Scaffold(
      backgroundColor: AppColors.primary.color,
      body: LayoutBuilder(builder: (context, constraint) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
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
                SizedBox(height: constraint.maxHeight * .05),
                Text(
                  "Pengurusan\nPerumahan",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.1,
                      height: 1.2,
                      fontSize: 28.sp),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: constraint.maxHeight * .1),
                const CircularProgressIndicator(
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
