import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:sansus_apps/routes/name_route.dart';

import '../widgets/circle_widget.dart';
import '../widgets/circle_pH.dart';
import '../controllers/sensor_controller.dart';
import '../controllers/weather_controller.dart';
import '../models/sensor_model.dart';

class HomePage extends StatelessWidget {
  final WeatherController weatherController = Get.find();
  final SensorController sensorController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xf5f5f5f5),
      appBar: AppBar(
        title: Center(
          child: Text(
            "Home",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Color(0xFF005AFF),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment(0.0, 3.0),
              children: [
                Stack(children: [
                  Container(
                    height: 170,
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                      gradient: LinearGradient(
                        colors: [Color(0xFF005AFF), Color(0xFF89ABEB)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Stack(
                      children: [],
                    ),
                  ),
                  Positioned(
                    top: 0, // Atur jarak dari atas
                    right: 20,
                    child: Image.asset('images/combine.png'),
                  ),
                  Positioned(
                    top: 0, // Atur jarak dari atas
                    left: 10,
                    child: Row(
                      children: [
                        Icon(
                          Icons.water_drop_rounded,
                          size: 60,
                          color: Colors.white,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "I-SANSUS",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Sanitasi Air Bersih Untuk Semua",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
                Transform.rotate(
                  alignment: Alignment(0.02, 0.0),
                  angle: -174 * (3.14 / 180),
                  child: Container(
                    height: 120,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Color(0xFFBED3FB),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                Container(
                  height: 120,
                  width: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF005AFF), Color(0xFF89ABEB)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Obx(() {
                      weatherController.getLocation();
                      return Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.place,
                                color: Colors.white,
                              ),
                              Text(
                                "${weatherController.weatherData.value.kota}, Indonesia",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${weatherController.weatherData.value.suhu}\u2103",
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Icon(
                                Icons.cloud,
                                size: 50,
                                color: Colors.white,
                              )
                            ],
                          )
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 66,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Informasi",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: GestureDetector(
                          // Pada bagian GestureDetector untuk suhu air
                          onTap: () {
                            double suhuValue = sensorController
                                .sensors.last.data.last.suhu
                                .toDouble()
                                .toPrecision(
                                    1); // Ambil nilai suhu dari SensorController
                            Widget suhuGraph = CustomPaint(
                              painter: CircleChart(suhuValue, false),
                              child: Container(
                                width: 100,
                                height: 100,
                                alignment: Alignment.center,
                                child: Text(
                                  '$suhuValue °C',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                            _showInfoPopup(
                                context,
                                "Suhu Air",
                                "Temperatur air yang bersih sebaiknya tidak terlalu panas atau terlalu dingin. Biasanya, suhu air bersih yang optimal berada dalam kisaran 20 hingga 28 derajat Celsius, memberikan rasa kesejukan dan nyaman bagi pengguna.",
                                suhuGraph,
                                suhuValue,
                                "Suhu");
                          },

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("images/suhu.png"),
                              Text(
                                "Suhu Air",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () {
                            double phValue = sensorController
                                .sensors.last.data.last.ph
                                .toDouble()
                                .toPrecision(
                                    1); // Ambil nilai suhu dari SensorController
                            Widget phGraph = CustomPaint(
                              painter: CircleChartpH(phValue, true),
                              child: Container(
                                width: 100,
                                height: 100,
                                alignment: Alignment.center,
                                child: Text(
                                  '$phValue',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                            _showInfoPopup(
                                context,
                                "pH Air",
                                "pH air untuk kebutuhan MCK (Mandi, Cuci, Kakus) biasanya berada dalam rentang 6.5 hingga 9. Kadar pH yang dianggap ideal untuk air adalah 7, yang menandakan keadaan netral.",
                                phGraph,
                                phValue,
                                "pH Air");
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("images/ph.png"),
                              Text(
                                "pH Air",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () {
                            double turbidityValue = sensorController
                                .sensors.last.data.last.turbidity
                                .toDouble()
                                .toPrecision(
                                    1); // Ambil nilai suhu dari SensorController
                            Widget tubidityGraph = CustomPaint(
                              painter: CircleChart(turbidityValue, true),
                              child: Container(
                                width: 100,
                                height: 100,
                                alignment: Alignment.center,
                                child: Text(
                                  '$turbidityValue %',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                            _showInfoPopup(
                                context,
                                "Kekeruhan Air",
                                "Kekeruhan air yang kurang dari 2% menunjukkan bahwa jumlah partikel padat atau zat terlarut dalam air relatif rendah, menciptakan air yang jernih dan bersih.",
                                tubidityGraph,
                                turbidityValue,
                                "Kekeruhan Air");
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("images/water.png"),
                              Text(
                                "Kekeruhan",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () {
                            double tdsValue = sensorController
                                .sensors.last.data.last.tds
                                .toDouble()
                                .toPrecision(
                                    0); // Ambil nilai suhu dari SensorController
                            Widget tdsGraph = CustomPaint(
                              painter: CircleChartpH(tdsValue, false),
                              child: Container(
                                width: 100,
                                height: 100,
                                alignment: Alignment.center,
                                child: Text(
                                  '${tdsValue.toInt()} ppm',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                            _showInfoPopup(
                                context,
                                "Tds Air",
                                "TDS atau Total Dissolved Solid adalah cara untuk memastikan air yang dikonsumsi bersih dan bebas dari berbagai zat berbahaya. Air Bersih untuk keperluan MCK ( Mandi Cuci Kakus ) tds yang ideal adalah 100 – 200 ppm",
                                tdsGraph,
                                tdsValue,
                                "Tds Air");
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("images/water-ec.png"),
                              Text(
                                "Tds Air",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Monitoring",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            StreamBuilder<List<Sensor>>(
                stream: sensorController.sensorStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text('Tidak Ada Data'),
                    );
                  }

                  final Sensor sensor = snapshot.data!.last;

                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 30),
                    child: Stack(
                      children: [
                        Container(
                          height: 150,
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(0, 1),
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomPaint(
                                            foregroundPainter: CircleChart(
                                                sensor.data.last.turbidity,
                                                true),
                                            child: Container(
                                              width: 125,
                                              height: 125,
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      '${sensor.data.last.turbidity.toDouble().toPrecision(1)}%',
                                                      style: TextStyle(
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Kondisi Air",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Container(
                                          height: 25,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: sensor.data.last.turbidity <
                                                        2 &&
                                                    sensor.data.last.tds < 120
                                                ? Colors.blue
                                                : Colors.red,
                                          ),
                                          child: Center(
                                            child: Text(
                                              sensor.data.last.turbidity < 2 &&
                                                      sensor.data.last.tds < 120
                                                  ? "Air Bersih"
                                                  : "Air Kotor",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Lihat Detail",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => {
                                        Get.offAllNamed(
                                          RouteName.monitoringPage,
                                        ),
                                      },
                                      child: Container(
                                        height: 25,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.blue,
                                        ),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue[50],
                            ),
                            child: Icon(
                              Icons.water_rounded,
                              size: 50,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            //   child: Container(
            //     height: 150,
            //     width: Get.width,
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(20),
            //         color: Colors.white,
            //         boxShadow: [
            //           BoxShadow(
            //             color: Colors.grey.withOpacity(0.5),
            //             spreadRadius: 1,
            //             blurRadius: 1,
            //             offset: Offset(0, 1),
            //           )
            //         ]),
            //   ),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Color(0xFF005AFF),
        style: TabStyle.custom,
        items: [
          TabItem(
            icon: Icons.home,
            title: 'Home',
          ),
          TabItem(
            icon: Icons.monitor,
            title: 'Monitoring',
          ),
        ],
        // cornerRadius: 30,
        initialActiveIndex: 0,
        onTap: (int i) {
          switch (i) {
            case 0:
              Get.offAllNamed(
                RouteName.homePage,
              );
              break;
            case 1:
              Get.offAllNamed(
                RouteName.monitoringPage,
              );
              break;
            default:
              break;
          }
        },
      ),
    );
  }
}

// Fungsi untuk menampilkan popup informasi dengan grafik
void _showInfoPopup(BuildContext context, String title, String content,
    Widget graphWidget, num sensorValue, String sensorLabel) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
          child: Text(title),
        ),
        contentPadding:
            EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Atur padding
        content: Container(
          height: MediaQuery.of(context).size.height *
              0.5, // Setengah dari tinggi layar
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(content),
              SizedBox(height: 16),
              Expanded(
                  child:
                      graphWidget), // Menggunakan Expanded untuk mengisi sisa ruang
              SizedBox(height: 16),
              Text(
                'Nilai $sensorLabel: $sensorValue',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
