class WeatherForecast {

  final String cityName;
  final List<ForecastData> forecastData;

  WeatherForecast({
    required this.cityName,
    required this.forecastData,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      cityName: json['location']['name'], 
      forecastData: (json['forecast']['forecastday'] as List)
          .map((e) => ForecastData.fromJson(e))
          .toList(),  
    );
  }
}

class ForecastData {
  final DateTime date;
  final double maxTemp;
  final double minTemp;
  final String condition;

  ForecastData({
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.condition,
  });

  factory ForecastData.fromJson(Map<String, dynamic> json) {
    return ForecastData(
      date: DateTime.parse(json['date']) ,
      maxTemp: (json['day']['maxtemp_c'] as num).toDouble(),
      minTemp: (json['day']['mintemp_c'] as num).toDouble(),
      condition: json['day']['condition']['text'],
    );
  }
}