import 'package:flutter/material.dart';
import 'package:weather_api/model/model.dart';
import '../model/ApiCall.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  WeatherApi? result;

  String cityName = "";

  void api(cityName) async {
    print(cityName);
    try {
      final api = await ApiCall().fetchWeather(cityName);
      print(api);
      setState(() {
        result = api;
      });
      print('API call successful: $api');
    } catch (e) {
      print('API call failed: $e');
    }
  }

  String direction(String direction) {
    switch (direction) {
      case "W":
        return "West";
      case "E":
        return "East";
      case "N":
        return "North";
      case "S":
        return "South";
    }
    return "East";
  }

  @override
  void initState() {
    super.initState();
    // if (result == null) {
    api("Thanjavur");
    // }
    print("hello");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(234, 234, 234, 1.0),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () async {
                    final selectedCity =
                        await Navigator.pushNamed(context, '/ChooseCities');
                    if (selectedCity != "") {
                      setState(() {
                        cityName = selectedCity.toString();
                        api(cityName); // Call the method to update weather for the selected city
                      });
                    }
                  },
                  icon: const Icon(Icons.add),
                  iconSize: 30.0,
                ),
                Text(
                  result != null ? result!.location.name : "Loading...",
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert,
                  ),
                  iconSize: 30.0,
                ),
              ],
            ),
            const SizedBox(height: 80.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 25.0),
                Text(
                  result != null ? result!.current.temperature : "20",
                  style: const TextStyle(
                    letterSpacing: -3.0,
                    fontSize: 85.0,
                    color: Colors.black,
                  ),
                ),
                const Baseline(
                  baseline: -9.0,
                  baselineType: TextBaseline.alphabetic,
                  child: Text(
                    '°C',
                    style: TextStyle(
                      fontSize: 27.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Baseline(
              baseline: -5.0,
              baselineType: TextBaseline.alphabetic,
              child: Text(
                result != null
                    ? result!.current.weatherDescription.first
                    : "Cloudy",
                style: const TextStyle(
                  fontSize: 13.0,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  constraints: BoxConstraints.tight(const Size(150, 100)),
                  margin: const EdgeInsets.fromLTRB(30.0, 40.0, 20.0, 20.0),
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(116, 140, 241, 1.0),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Wind",
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.white,
                        ),
                      ),
                      //SizedBox(height: 5.0),
                      Text(
                        result != null
                            ? "${result!.current.windSpeed} km/h"
                            : "2 km/h",
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      //SizedBox(height: 5.0),
                      Text(
                        result != null
                            ? direction(result!.current.windDir)
                            : "East",
                        style: const TextStyle(
                          fontSize: 10.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  constraints: BoxConstraints.tight(const Size(150, 100)),
                  margin: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 20.0),
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(116, 140, 241, 1.0),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Humidity",
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.white,
                        ),
                      ),
                      //SizedBox(height: 5.0),
                      Text(
                        result != null ? "${result!.current.humidity}%" : "69%",
                        style: const TextStyle(
                          fontSize: 19.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  constraints: BoxConstraints.tight(const Size(150, 100)),
                  margin: const EdgeInsets.fromLTRB(30.0, 20.0, 20.0, 20.0),
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(116, 140, 241, 1.0),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Real Feel",
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.white,
                        ),
                      ),
                      //SizedBox(height: 5.0),
                      Text(
                        result != null
                            ? "${result!.current.feelslike}°C"
                            : "31°C",
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  constraints: BoxConstraints.tight(const Size(150, 100)),
                  margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(116, 140, 241, 1.0),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Pressure",
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.white,
                        ),
                      ),
                      //SizedBox(height: 5.0),
                      Text(
                        result != null
                            ? "${result!.current.pressure}mb"
                            : "1000mb",
                        style: const TextStyle(
                          fontSize: 17.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  constraints: BoxConstraints.tight(const Size(150, 100)),
                  margin: const EdgeInsets.fromLTRB(30.0, 20.0, 20.0, 20.0),
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(116, 140, 241, 1.0),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Visibility",
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.white,
                        ),
                      ),
                      //SizedBox(height: 5.0),
                      Text(
                        result != null
                            ? "${result!.current.visibility}km"
                            : "3km",
                        style: const TextStyle(
                          fontSize: 19.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  constraints: BoxConstraints.tight(const Size(150, 100)),
                  margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 10.0),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(116, 140, 241, 1.0),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "UV Index",
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.white,
                        ),
                      ),
                      // SizedBox(height: 5.0),
                      Text(
                        result != null ? result!.current.uvIndex : "3",
                        style: const TextStyle(
                          fontSize: 19.0,
                          color: Colors.white,
                        ),
                      ),
                      // Text(
                      //   "Set\t\t\t\t5.17 pm%",
                      //   style: TextStyle(
                      //     fontSize: 14.0,
                      //     color: Colors.white,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
