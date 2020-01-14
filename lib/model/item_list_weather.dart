import 'package:weather_app/model/Weather.dart';

class ItemListWeather {
  String date;
  List<Weather> list = List();

  ItemListWeather({this.date, this.list});
}