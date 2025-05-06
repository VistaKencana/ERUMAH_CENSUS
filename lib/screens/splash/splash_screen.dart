import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:eperumahan_bancian/config/constants/app_images.dart';
import 'package:eperumahan_bancian/config/routes/routes_name.dart';
import 'package:eperumahan_bancian/data/hive-manager/repository/login_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _handleStartup();
  }

  Future<void> _handleStartup() async {
    bool allGranted = await _checkAndRequestPermissions();

    if (allGranted) {
      await Future.delayed(const Duration(milliseconds: 3500));
    } else {
      // Wait a little longer after permissions are granted
      await Future.delayed(const Duration(milliseconds: 2000));
    }

    _navigateBasedOnLogin();
  }

  Future<bool> _checkAndRequestPermissions() async {
    final cameraStatus = await Permission.camera.status;
    final storageStatus = await Permission.storage.status;

    bool cameraGranted = cameraStatus.isGranted;
    bool storageGranted = storageStatus.isGranted;

    if (!cameraGranted) {
      final newStatus = await Permission.camera.request();
      cameraGranted = newStatus.isGranted;
    }

    if (!storageGranted) {
      final newStatus = await Permission.storage.request();
      storageGranted = newStatus.isGranted;
    }

    return cameraGranted && storageGranted;
  }

  void _navigateBasedOnLogin() {
    final isLoggedIn = LoginPreference().isTokenExpired() != null;

    Navigator.pushNamedAndRemoveUntil(
      context,
      isLoggedIn ? RoutesName.home : RoutesName.login,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppImages.splash.path), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 38 / 9,
                child: Image.asset(
                  AppImages.dbklLogo.path,
                  fit: BoxFit.contain,
                  height: constraint.maxHeight * .2,
                  width: constraint.maxWidth * .4,
                ),
              ),
              SizedBox(height: constraint.maxHeight * .04),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "PENGURUSAN PERUMAHAN",
                  style: appTextStyle(
                      size: 30.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: constraint.maxHeight * .05),
              const CircularProgressIndicator(
                color: Colors.white,
              )
            ],
          ),
        ),
      );
    });
  }
}
