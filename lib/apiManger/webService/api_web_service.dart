import 'dart:convert';
import 'package:weather_app_v2/apiManger/models/current_weather.dart';
import 'package:weather_app_v2/apiManger/models/main.dart';
import 'package:weather_app_v2/apiManger/models/weather.dart';
import 'package:http/http.dart' as http;

class ApiWebService {
  static const String _baseUrl = 'api.openweathermap.org';
  static const String _unicode = '/data/2.5/weather';
  static const String _apiKey = '494eecd541ba0541592b2b751288602a';
  // List<String, dynamic> query_params = {};
  Future<CurrentWeather> getResponse(String city) async {
    final _query_params = {'q': city, 'appid': _apiKey};
    // created the link
    final uri = Uri.https(_baseUrl, _unicode, _query_params);
    // get respose
    final uri_response = await http.get(uri);
    // convert json file to the data class
    if (uri_response.statusCode == 200) {
      // get uri as json file
      final jsonFile = jsonDecode(uri_response.body);
      // return object class
      return CurrentWeather.fromJson(jsonFile);
    } else {
      return CurrentWeather();
    }
  }
}
