import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  Weather? _weather;
  bool _isLoading = false;

  Weather? get weather => _weather;
  bool get isLoading => _isLoading;

  Future<void> fetchWeather(String cityName) async {
    _isLoading = true;
    notifyListeners();

    try {
      final fetchedWeather = await WeatherService.fetchWeather(cityName);
      _weather = fetchedWeather;
      saveLastSearchedCity(cityName);
    } catch (error) {
      print('Failed to fetch weather data: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveLastSearchedCity(String cityName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastCity', cityName);
  }

  Future<String?> getLastSearchedCity() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('lastCity');
  }
}
