import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather/services/network.dart';
import '../services/location.dart';
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
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 200.0,
          height: 100.0,
          child: Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.grey,
            child: Image.network(
              'https://docs.flutter.dev/cookbook'
              '/img-files/effects/split-check/Avatar1.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();

    latitude = location.latitude.toString();
    longitude = location.longitude.toString();
    Network network = Network(
      baseUrl: 'api.openweathermap.org',
      queryParams: {
        'lat': latitude,
        'lon': longitude,
        'appid': 'e6a408a269f71f41295ca971a9ec2323',
      },
    );
    var weatherData = await network.getData();

    if (context.mounted) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LocationScreen();
      }));
    }
  }
}
