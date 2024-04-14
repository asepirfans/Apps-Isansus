import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

class WeatherData {
  String kota;
  double suhu;

  WeatherData({required this.kota, required this.suhu});
}

class WeatherController extends GetxController {
  var location = Location();
  var apiKey = '8ff9b5c62135093e3597c5af03587d0e';
  var weatherData = WeatherData(kota: '', suhu: 0.0).obs;
  var isWeatherLoaded = false.obs; // Menambah variabel state

  Future<void> getLocation() async {
    try {
      var currentLocation = await location.getLocation();
      print("Lokasi: $currentLocation");
      getWeatherData(currentLocation.latitude!, currentLocation.longitude!);
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  Future<void> getWeatherData(double latitude, double longitude) async {
    if (isWeatherLoaded.value) {
      // Jika data cuaca sudah dimuat, keluar dari fungsi
      return;
    }

    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      double kelvinTemperature = data['main']['temp'];
      double celsiusTemperature = kelvinTemperature - 273.15;
      weatherData.update((val) {
        val!.kota = data['name'];
        val.suhu = celsiusTemperature.toPrecision(1);
      });
      print('Kota: ${weatherData.value.kota}');
      print('Suhu: ${weatherData.value.suhu}');
      isWeatherLoaded.value = true; // Menandakan bahwa data cuaca sudah dimuat
    } else {
      print("Error getting weather data: ${response.reasonPhrase}");
    }
  }
}
