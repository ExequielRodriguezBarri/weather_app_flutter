import 'package:flutter/material.dart';

import '../model/weather.dart';
import '../services/weatherlink.dart';

class WeatherViewModel extends ChangeNotifier {
  late Weather _weatherData;
  final _weatherlinkData = Weatherlink();

  bool isLoading = true;

  // Weather icon based on conditions
  IconData get icon {
    // Check if it's night time (from 6 PM to 6 AM)
    if (_isNightTime()) {
      return Icons.nightlight_round;  // Moon icon for night
    } 
    // Check if it's windy
    else if (_weatherData.windSpeed > 20) {
      return Icons.wind_power;  // Windy weather
    } 
    // Check if it's rainy
    else if (_weatherData.humidity > 80) {
      return Icons.water_drop;  // Rainy weather
    } 
    // Check if it's sunny and hot
    else if (_weatherData.temperature > 30) {
      return Icons.wb_sunny_outlined;  // Hot and sunny
    } 
    // Check if it's cold (snow)
    else if (_weatherData.temperature < 10) {
      return Icons.ac_unit;  // Cold weather (snow)
    } 
    // Default to cloudy
    else {
      return Icons.cloud;  // Default to cloudy
    }
  }

  int get currentTemp {
    return _weatherData.temperature;
  }

  int get feelsLike {
    return _weatherData.feelsLikeTemperature;
  }

  String get windDirection {
    return _getWindDirectionFromDegrees(_weatherData.windDirection);
  }

  int get windSpeed {
    return _weatherData.windSpeed;
  }

  int get humidity {
    return _weatherData.humidity;
  }

  DateTime get lastUpdated {
    return _weatherData.lastUpdated;
  }

  WeatherViewModel() {
    refresh();
  }

  Future<void> refresh() async {
    isLoading = true;
    notifyListeners();

    final weatherFuture = _weatherlinkData.getWeather();
    final timingFuture = Future.delayed(const Duration(milliseconds: 800));
    _weatherData = await weatherFuture;

    // for visualization purposes
    await timingFuture;

    isLoading = false;
    notifyListeners();
  }

  // Helper function to convert degrees into readable wind direction
  String _getWindDirectionFromDegrees(int degrees) {
    if (degrees >= 337 || degrees < 23) return "N";   // North (0 - 23 or 337 - 360 degrees)
    if (degrees >= 23 && degrees < 68) return "NE";     // North-East (23 - 68 degrees)
    if (degrees >= 68 && degrees < 113) return "E";     // East (68 - 113 degrees)
    if (degrees >= 113 && degrees < 158) return "SE";    // South-East (113 - 158 degrees)
    if (degrees >= 158 && degrees < 203) return "S";     // South (158 - 203 degrees)
    if (degrees >= 203 && degrees < 248) return "SW";    // South-West (203 - 248 degrees)
    if (degrees >= 248 && degrees < 293) return "W";     // West (248 - 293 degrees)
    if (degrees >= 293 && degrees < 337) return "NW";    // North-West (293 - 337 degrees)
    return "Unknown";  // In case of invalid or missing data
  }

  // Helper function to determine if it's night time (6 PM to 6 AM)
  bool _isNightTime() {
    final currentHour = DateTime.now().hour;
    return currentHour >= 18 || currentHour < 6;  // Nighttime is between 6 PM and 6 AM
  }
}
