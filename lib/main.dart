import 'package:flutter/material.dart';
import 'package:weather_api/Screens/choose_cities.dart';
import 'package:weather_api/Screens/home.dart';

void main() {
  runApp(MaterialApp(
    home: const Home(),
    routes: {
      '/Home': (context) => const Home(),
      '/ChooseCities': (context) => const ChooseCities(),
    },
  ));
}
