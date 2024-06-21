import 'dart:async';

import 'package:eperumahan_bancian/config/routes/routes_generator.dart';
import 'package:eperumahan_bancian/config/routes/routes_name.dart';
import 'package:eperumahan_bancian/config/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
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
    );
  }
}
