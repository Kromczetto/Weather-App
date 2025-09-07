import 'package:flutter/material.dart';
import 'package:weatherapp/services/weather_service.dart';
import 'package:weatherapp/models/weather_model.dart';

class LocationWeather extends StatefulWidget {
  const LocationWeather({super.key});

  @override
  State<LocationWeather> createState() => _LocationWeatherState();
}

class _LocationWeatherState extends State<LocationWeather> {
  final _weatherService = WeatherService('f9b9e140a2be4b58b2d134424250609');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();
    print(cityName);
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }
  @override 
  void initState() {
    super.initState();
    _fetchWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: Text("Go Back"), 
              ),
            ),
            
            Center(
              child: _weather != null 
                ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  Positioned.fill(
                    child: Image.network(
                      _weather!.iconUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    _weather!.cityName,
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _weather!.temperature.toString() + ' °C',
                    style: const TextStyle(fontSize: 24),
                    ),
                  Text(
                    _weather!.condition,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
                ) : CircularProgressIndicator(),
            ), 
        ])
      )
    );
  }
}