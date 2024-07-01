import 'package:eperumahan_bancian/config/routes/routes_error.dart';
import 'package:eperumahan_bancian/config/routes/routes_name.dart';
import 'package:eperumahan_bancian/screens/activity/activity_search_screen.dart';
import 'package:eperumahan_bancian/screens/home_screen.dart';
import 'package:eperumahan_bancian/screens/login/login_screen.dart';
import 'package:eperumahan_bancian/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class RoutesGenerator {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            settings: const RouteSettings(name: RoutesName.splash),
            builder: (context) => const SplashScreen());
      case RoutesName.login:
        return PageTransition(
            settings: const RouteSettings(name: RoutesName.login),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 2500),
            child: const LoginScreen());
      case RoutesName.home:
        return PageTransition(
            type: PageTransitionType.rightToLeft,
            settings: const RouteSettings(name: RoutesName.home),
            child: const HomeScreen());
      case RoutesName.activitySearch:
        return PageTransition(
            type: PageTransitionType.bottomToTop,
            settings: const RouteSettings(name: RoutesName.activitySearch),
            child: const ActivitySearchScreen());
      default:
        return RoutesError.errorRoute();
    }
  }
}
