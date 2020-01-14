import 'package:intl/intl.dart';

import 'City.dart';
import 'Weather.dart';
import 'X.dart';
import 'item_list_weather.dart';

class WeatherResponse {
    City city;
    int cnt;
    String cod;
    List<X> list;
    dynamic message;
    String error;
    String name;

    WeatherResponse({this.city, this.cnt, this.cod, this.list, this.message});

    factory WeatherResponse.fromJson(Map<String, dynamic> json) {
        return WeatherResponse(
            city: json['city'] != null ? City.fromJson(json['city']) : null, 
            cnt: json['cnt'], 
            cod: json['cod'], 
            list: json['list'] != null ? (json['list'] as List).map((i) => X.fromJson(i)).toList() : null, 
            message: json['message'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['cnt'] = this.cnt;
        data['cod'] = this.cod;
        data['message'] = this.message;
        if (this.city != null) {
            data['city'] = this.city.toJson();
        }
        if (this.list != null) {
            data['list'] = this.list.map((v) => v.toJson()).toList();
        }
        return data;
    }

    WeatherResponse.withError(String error) : list = List(), error = error;

    List<ItemListWeather> getItem() {
        List<ItemListWeather> listItem = List();
        var dateFormatter = DateFormat('yyyy-MM-dd');
        var hourFormatter = DateFormat('hh:mm');

        DateTime dateTmp;
        ItemListWeather itemList;
        List<Weather> listWeather = List();
        for(var i = 1; i < list.length; i++) {
            var date = DateTime.parse(dateFormatter.format(DateTime.parse(list[i++].dt_txt)));
            var model = list[i++];

            if (dateTmp != date) {
                if (listWeather.length > 0) {
                    itemList.list = listWeather;
                    listItem.add(itemList);
                }
                itemList = ItemListWeather();
                listWeather = List();
                itemList.date = dateFormatter.format(DateTime.parse(model.dt_txt));
                dateTmp = date;
            }

            Weather weather = model.weather[0];
            weather.hour = hourFormatter.format(DateTime.parse(model.dt_txt));
            listWeather.add(weather);

        }

        return listItem;
    }
}