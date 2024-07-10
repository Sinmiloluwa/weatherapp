import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather/services/weather.dart';
import 'location.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late String latitude;
  late String longitude;
  @override
  void initState() {
    super.initState();
    print('all time');
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/logos/logo-no-background.png'),
              fit: BoxFit.cover,
            ),
          ),
          width: 200,
          height: 200,
        ),
      ),
    );
  }

  void getLocation() async {
    WeatherModel weather = WeatherModel();
    var data = await weather.getLocationWeather();
    await Future.delayed(const Duration(seconds: 2));

    if (context.mounted) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LocationScreen(weatherData: data);
      }));
    }
  }
}
