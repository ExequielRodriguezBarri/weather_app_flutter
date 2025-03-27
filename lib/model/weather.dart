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
    try {
      // Locate the sensor with weather-related data (sensor_type: 45)
      var sensor = (data['sensors'] as List<dynamic>)
          .firstWhere((s) => s['sensor_type'] == 45, orElse: () => {});

      if (sensor.isNotEmpty && sensor['data'] != null) {
        var sensorData = sensor['data'][0]; // Get the latest data entry

        windSpeed = (sensorData['wind_speed_last'] as num?)?.toInt() ?? 4;
        windDirection = (sensorData['wind_dir_last'] as num?)?.toInt() ?? 33;
        humidity = (sensorData['hum'] as num?)?.toInt() ?? 65;
        temperature = (sensorData['temp'] as num?)?.toInt() ?? 72;
        feelsLikeTemperature = (sensorData['thw_index'] as num?)?.toInt() ?? 70;
      } else {
        throw Exception("No valid weather sensor data found.");
      }
    } catch (e) {
      windSpeed = -1;
      windDirection = -1;
      humidity = -1;
      temperature = -1;
      feelsLikeTemperature = -1;
    }
  }
}

