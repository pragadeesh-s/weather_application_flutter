class WeatherApi {
  final Current current;
  final Location location;

  WeatherApi({
    required this.current,
    required this.location,
  });

  factory WeatherApi.fromMap(Map<String, dynamic> map) {
    print('Map - $map');
    return WeatherApi(
      current: Current.fromMap(map['current']),
      location: Location.fromMap(map['location']),
    );
  }
}

class Current {
  final String temperature;
  final String windDir;
  final String windSpeed;
  final String pressure;
  final String humidity;
  final String feelslike;
  final String visibility;
  final String uvIndex;
  final List<dynamic> weatherDescription;

  Current({
    required this.temperature,
    required this.windSpeed,
    required this.windDir,
    required this.pressure,
    required this.humidity,
    required this.feelslike,
    required this.visibility,
    required this.uvIndex,
    required this.weatherDescription,
  });

  factory Current.fromMap(Map<String, dynamic> map) {
    return Current(
      temperature: map['temperature'].toString(),
      windSpeed: map['wind_speed'].toString(),
      windDir: map['wind_dir'].toString(),
      pressure: map['pressure'].toString(),
      humidity: map['humidity'].toString(),
      feelslike: map['feelslike'].toString(),
      visibility: map['visibility'].toString(),
      uvIndex: map['uv_index'].toString(),
      weatherDescription: map['weather_descriptions']
          .map((description) => description as String)
          .toList(),
    );
  }
}

class Location {
  final String name;

  Location({
    required this.name,
  });

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      name: map['name'],
    );
  }
}
