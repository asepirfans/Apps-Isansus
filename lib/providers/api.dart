import 'package:http/http.dart' as http;

class ApiController {
  static const String URL_API = "https://be-isansus.vercel.app";

  Future<http.Response> fetchData() async {
    try {
      final response = await http.get(Uri.parse('$URL_API/api/sensor'));
      print('Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception(
            'Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during fetchData: $e');
      throw e;
    }
  }
}
