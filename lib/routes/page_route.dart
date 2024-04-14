import 'package:get/get.dart';

import 'name_route.dart';
import '../pages/home_page.dart';
import '../pages/monitoring_page.dart';
import '../pages/splashscreen_page.dart';

class AppPage {
  static final pages = [
    GetPage(
      name: RouteName.homePage,
      page: () => HomePage(),
    ),
    GetPage(
      name: RouteName.monitoringPage,
      page: () => MonitoringPage(),
    ),
    GetPage(
      name: RouteName.splashScreenPage,
      page: () => SplashScreen(),
    ),
  ];
}