import 'package:flutter/material.dart';

class LocationWeather extends StatefulWidget {
  const LocationWeather({super.key});

  @override
  State<LocationWeather> createState() => _LocationWeatherState();
}

class _LocationWeatherState extends State<LocationWeather> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Location Weather")
    );
  }
}