import 'dart:async';

import 'package:weather_app/api/api_provider.dart';
import 'package:weather_app/model/WeatherResponse.dart';

class HomeBloc{

  final ApiProvider apiProvider = ApiProvider();
  final _weatherResponse = StreamController<WeatherResponse>.broadcast();
  final _isLoading = StreamController<bool>();

  Stream<WeatherResponse> get response => _weatherResponse.stream;
  Stream<bool> get loading => _isLoading.stream;

  Function(WeatherResponse) get setResponse => _weatherResponse.sink.add;
  Function(bool) get setLoading => _isLoading.sink.add;

  void getWeather(int zipCode) async {
    setLoading(true);
    WeatherResponse response   = await apiProvider.getWeather(zipCode);
    setLoading(false);
    setResponse(response);
  }

  void initiate() {
    setLoading(false);
  }

  void dispose() {
    _weatherResponse.close();
    _isLoading.close();
  }

}