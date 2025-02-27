import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/weather.dart';

class Weatherlink {
  final http.Client httpClient = http.Client();
  final String url = 'https://us-central1-oc-weather-25.cloudfunctions.net/weather';

  Future<Weather> getWeather() async {
    try {
      final response = await httpClient.get(Uri.parse(url)); // Make an HTTP request

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body); // Decode JSON
        return Weather.fromWeatherlink(jsonData); // Pass real data to Weather model
      } else {
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching weather data: $e');
    }
  }
}
