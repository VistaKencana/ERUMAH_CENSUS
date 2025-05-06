import 'dart:async';
import 'package:eperumahan_bancian/config/blocs/app_blocs.dart';
import 'package:eperumahan_bancian/data/api/api_client.dart';
import 'package:eperumahan_bancian/data/api/api_env.dart';
import 'package:eperumahan_bancian/services/app_info.dart';
import 'package:eperumahan_bancian/services/draw_watermark.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:eperumahan_bancian/config/routes/routes_generator.dart';
import 'package:eperumahan_bancian/config/routes/routes_name.dart';
import 'package:eperumahan_bancian/config/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'config/constants/app_size.dart';
import 'config/providers/app_provider.dart';
import 'data/hive-manager/hive_manager.dart';
import 'services/easyloading_config.dart';
import 'services/mobile_info.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApiClient.init(ApiEnv.dev.baseUrl);
  // await _requestPermission();
  await Future.wait([
    AppInfo.init(),
    DrawWatermark.initializeFont(),
    HiveBoxPreference.init(),
    EasyLoadingConfig.init(),
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]),
  ]);
  runApp(MultiBlocProvider(
    providers: [...AppBlocs.listOfBloc, ...AppProviders.providers],
    child: const MyApp(),
  ));
}

// _requestPermission() async {
//   var status = await Permission.camera.status;
//   if (!status.isGranted) {
//     await Permission.camera.request();
//   }
//   await Permission.storage.request();
// }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    MobileInfo.init(context);
  }

  @override
  Widget build(BuildContext context) {
    AppSize().initialize(context);
    return ScreenUtilInit(
      child: MaterialApp(
        title: 'ePerumahan Bancian',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        //THEME
        themeMode: ThemeMode.light,
        theme: AppThemes.of(context).lightTheme,
        darkTheme: AppThemes.of(context).darkTheme,
        //ROUTES
        initialRoute: RoutesName.splash,
        onGenerateRoute: RoutesGenerator.generateRoutes,
        builder: EasyLoading.init(),
      ),
    );
  }
}
