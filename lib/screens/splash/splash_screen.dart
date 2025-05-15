import 'package:eperumahan_bancian/config/constants/app_images.dart';
import 'package:eperumahan_bancian/config/routes/routes_name.dart';
import 'package:eperumahan_bancian/data/hive-manager/repository/login_pref.dart';
import 'package:flutter/material.dart';
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
    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, RoutesName.login);
      Navigator.pushNamed(context, RoutesName.home);
      return;
    }
    Navigator.pushNamedAndRemoveUntil(
      context,
      isLoggedIn ? RoutesName.home : RoutesName.login,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
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
