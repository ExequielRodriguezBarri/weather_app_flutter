import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/weather.dart';

class Weatherlink {
  final httpClient = http.Client();

  Future<Weather> getWeather() async {
    final httpPayload = <String, dynamic>{'url': 'https://us-central1-oc-weather-25.cloudfunctions.net/weather'};
    return Weather.fromWeatherlink(httpPayload);
  }
}
