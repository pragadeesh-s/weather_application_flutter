import 'dart:convert';
import 'package:http/http.dart';
import 'model.dart';

class ApiCall {
  Future<WeatherApi> fetchWeather(String cityName) async {
    print("city-name: $cityName");
    String url =
        "http://api.weatherstack.com/current?access_key=234e973dc867ee1744f211d01c9518c1&query=$cityName";
    Uri uri = Uri.parse(url);
    Response response = await get(uri);
    print(response.body);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final datamodel = WeatherApi.fromMap(json);
      return datamodel;
    } else {
      throw Exception("Failed to load the data");
    }
  }
}
