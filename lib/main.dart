import 'dart:async';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:eperumahan_bancian/config/routes/routes_generator.dart';
import 'package:eperumahan_bancian/config/routes/routes_name.dart';
import 'package:eperumahan_bancian/config/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'services/easyloading_config.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLoadingConfig.init();
  await _requestPermission();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

_requestPermission() async {
  var status = await Permission.camera.status;
  if (!status.isGranted) {
    Permission.camera.request();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ePerumahan Bancian',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      //THEME
      themeMode: ThemeMode.light,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      //ROUTES
      initialRoute: RoutesName.splash,
      onGenerateRoute: RoutesGenerator.generateRoutes,
      builder: EasyLoading.init(),
    );
  }
}
