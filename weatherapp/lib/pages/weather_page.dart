import 'package:flutter/material.dart';
import 'package:weatherapp/services/weather_service.dart';
import 'package:weatherapp/models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  final _weatherService = WeatherService('f9b9e140a2be4b58b2d134424250609');
  Weather? _weather;
  String selectedCity = "Gliwice";
  List<String> cities = ["Gliwice", "Hamburg"];
  _fetchWeather() async {
    try {
    final weather = await _weatherService.getWeather(selectedCity);
    setState(() {
      _weather = weather;
    });
  }
  catch (e) {
    print(e);
  }
  }
  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }
  void _addCity() {
    String newCity = '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add City'),
        content: TextField(
          onChanged: (value) {
            newCity = value;
          },
          decoration: const InputDecoration(hintText: 'Enter city name'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (newCity.isNotEmpty && !cities.contains(newCity)) {
                setState(() {
                  cities.add(newCity);
                  selectedCity = newCity;
                  _fetchWeather();
                });
              }
              Navigator.of(context).pop();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addCity,
          ),
        ],
      ),
       body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedCity,
                items: cities.map((city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCity = value!;
                    _fetchWeather();
                  });
                },
              ),
            ),
            if (_weather != null) ...[
              Text(
                _weather!.cityName,
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Text(
                '${_weather!.temperature} °C',
                style: const TextStyle(fontSize: 24),
              ),
              Text(
                _weather!.condition,
                style: const TextStyle(fontSize: 20),
              ),
            ] else ...[
              const CircularProgressIndicator(),
            ],
          ],
          )
        )
    );
  }
}