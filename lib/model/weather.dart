//I am guessing this hw is going to take me about 3 hs

class Weather {
  late final int windSpeed;
  late final int windDirection;
  late final int humidity;
  late final int temperature;
  late final int feelsLikeTemperature;
  final DateTime lastUpdated;

  Weather.fromWeatherlink(Map<String, dynamic> data)
      : lastUpdated = DateTime.now() {
        windSpeed = 90;
        windDirection = 91;
        humidity = 92;
        temperature = 93;
        feelsLikeTemperature = 94;
  }
}
