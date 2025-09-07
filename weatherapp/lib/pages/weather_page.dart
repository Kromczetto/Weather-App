import 'package:flutter/material.dart';
import 'package:weatherapp/pages/your_location_weather_page.dart';
import 'package:weatherapp/services/weather_service.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/models/weather_forecast_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  final _weatherService = WeatherService('f9b9e140a2be4b58b2d134424250609');
  
  Weather? _weather;
  WeatherForecast? _weatherForecast;

  String selectedCity = "Gliwice";
  List<String> cities = ["Gliwice", "Hamburg"];
  _fetchWeather() async {
    try {
    final weather = await _weatherService.getWeather(selectedCity);
    final WeatherForecast = await _weatherService.getWeatherForecast(selectedCity);

    setState(() {
      _weather = weather;
      _weatherForecast = WeatherForecast;
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
  String getDayNameFromDate(DateTime date) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
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
            onPressed: () async {
              if (newCity.isNotEmpty && !cities.contains(newCity)) {
                try {
                  await _weatherService.getWeather(newCity);
                  Navigator.of(context).pop();
                  setState(() {
                    cities.add(newCity);
                    selectedCity = newCity;
                    _fetchWeather();
                  });
                } catch (e) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Error'),
                      content: const Text('City not found. Please try again.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              } else {
                Navigator.of(context).pop();
              }
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
        backgroundColor: Colors.white70,
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
                    child: Center(
                      child: Text(city)
                    ),
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
              SizedBox(height: 50),
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
              SizedBox(height: 80),
              if (_weatherForecast != null) ...[
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _weatherForecast!.forecastData.length,
                    itemBuilder: (context, index) {
                      final dayWeather = _weatherForecast!.forecastData[index];
                      final dayName = getDayNameFromDate(dayWeather.date);
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(dayName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                              Text('Min: ${dayWeather.minTemp} °C'),
                              Text('Max: ${dayWeather.maxTemp} °C'),
                              Text(dayWeather.condition),
                            ],
                          ),
                        )
                      );
                    },
                  )
                ),
                SizedBox(height: 60),
                ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => LocationWeather()),
                  );
                }, 
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: Text("Your Location Weather")
              )
              ]
              

            ] else ...[
              const CircularProgressIndicator(),
            ],
          ],
          )
        )
    );
  }
}