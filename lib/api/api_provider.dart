
import 'dart:convert';

import 'package:weather_app/model/WeatherResponse.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  final String _apiKey = 'ea0ab496bc2f4e9c0cc7af9baee579c8';
  final String _endpoint = 'api.openweathermap.org';

  Future<WeatherResponse> getWeather(int zipCode) {
    var uri = Uri.http('$_endpoint', '/data/2.5/forecast',
        {'zip': '$zipCode,us', 'units': 'metric', 'lang': 'id', 'appid': '$_apiKey'});

    return http.get(uri).then((response) {
      if (response.statusCode == 200) {
        return WeatherResponse.fromJson(json.decode(response.body));
      }
      return WeatherResponse.withError('Error');
    });
  }
}