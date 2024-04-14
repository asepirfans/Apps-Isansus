import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sansus_apps/pages/splashscreen_page.dart';

import 'routes/page_route.dart';
import 'controllers/sensor_controller.dart';
import 'controllers/weather_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(SensorController());
  Get.put(WeatherController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      getPages: AppPage.pages,
    );
  }
}

