import 'package:weather/services/network.dart';
import '../services/location.dart';

class WeatherModel {
  late String baseUrl = 'api.openweathermap.org';

  Future<dynamic> getCityWeather(String cityName) async {
    Network network = Network(baseUrl: baseUrl, queryParams: {
      'q': cityName,
      'appid': 'e6a408a269f71f41295ca971a9ec2323',
      'units': 'metric'
    });

    var weatherData = await network.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    Network network = Network(
      baseUrl: 'api.openweathermap.org',
      queryParams: {
        'lat': location.latitude.toString(),
        'lon': location.longitude.toString(),
        'appid': 'e6a408a269f71f41295ca971a9ec2323',
        'units': 'metric'
      },
    );
    var data = await network.getData();

    return data;
  }

  String getWeatherIcon(int condition) {
    print(condition);
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
