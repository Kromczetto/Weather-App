import 'dart:convert';

import '../models/weather_model.dart';
import '../models/weather_forecast_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {

  static const URL = "http://api.weatherapi.com/v1";
  final String apiKey;
  WeatherService(this.apiKey); 
  
  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(Uri.parse('$URL/current.json?key=$apiKey&q=$cityName&aqi=no'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
  
  Future<WeatherForecast> getWeatherForecast(String cityName) async {
    final response = await http.get(Uri.parse('$URL/forecast.json?key=$apiKey&q=$cityName&days=5&aqi=no&alerts=no'));

    if (response.statusCode == 200) {
      return WeatherForecast.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather forecast data');
    }
  }
}