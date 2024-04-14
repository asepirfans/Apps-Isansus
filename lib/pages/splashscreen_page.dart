import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/name_route.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Menambahkan delay sebelum pindah ke HomePage
    Future.delayed(Duration(seconds: 3), () {
      Get.offAllNamed(
        RouteName.homePage,
        
      );
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF89ABEB), Color(0xF5F5F5F5)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                'images/isansus2.png',
                height: 300,
                width: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
