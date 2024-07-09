import 'package:http/http.dart' as client;
import 'dart:convert';

class Network {
  final String baseUrl;
  final Map<String, String>? queryParams;

  Network({required this.baseUrl, this.queryParams});

  Future<void> getData() async {
    Uri url = Uri.https(baseUrl, '/data/2.5/weather', queryParams);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
