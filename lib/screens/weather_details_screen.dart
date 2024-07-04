import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import 'home_screen.dart';

class WeatherDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/background.jpg',
            fit: BoxFit.cover,
            // color: Colors.black.withOpacity(0.6),
            colorBlendMode: BlendMode.darken,
          ),
          Center(
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 32.0),
              color: Colors.black.withOpacity(0.3),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Text(
                            weatherProvider.weather!.cityName,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '${weatherProvider.weather!.temperature}°C',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Image.network(
                            'http://openweathermap.org/img/wn/${weatherProvider.weather!.icon}.png',
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                  'assets/weather_icon_placeholder.png');
                            },
                          ),
                          SizedBox(height: 10),
                          Text(
                            weatherProvider.weather!.condition.capitalize(),
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Details',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Humidity:',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${weatherProvider.weather!.humidity}%',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Wind Speed:',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${weatherProvider.weather!.windSpeed} m/s',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pressure:',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${weatherProvider.weather!.pressure} hPa',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sunrise:',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${weatherProvider.weather!.sunrise}',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sunset:',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${weatherProvider.weather!.sunset}',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            // width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                weatherProvider.fetchWeather(
                                    weatherProvider.weather!.cityName);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                                padding: EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                minimumSize: Size(double.infinity / 2, 55),
                              ),
                              child: weatherProvider.isLoading
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    )
                                  : Text(
                                      'Refresh',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                                padding: EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                minimumSize: Size(double.infinity / 2, 55),
                              ),
                              child: Text(
                                'New Location',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
