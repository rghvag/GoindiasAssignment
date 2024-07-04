import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

class WeatherService {
  // static const _apiKey = 'YOUR_API_KEY_HERE'; // Replace with your OpenWeatherMap API key
  static const _apiKey = '3111db94bc75fc59e02df601afbae3d5';

  static Future<Weather> fetchWeather(String cityName) async {
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=$_apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Weather.fromJson(data);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
