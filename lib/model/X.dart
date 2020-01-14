
import 'Clouds.dart';
import 'Main.dart';
import 'Sys.dart';
import 'Weather.dart';
import 'Wind.dart';

class X {
    Clouds clouds;
    int dt;
    String dt_txt;
    Main main;
    Sys sys;
    List<Weather> weather;
    Wind wind;

    X({this.clouds, this.dt, this.dt_txt, this.main, this.sys, this.weather, this.wind});

    factory X.fromJson(Map<String, dynamic> json) {
        return X(
            clouds: json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null, 
            dt: json['dt'], 
            dt_txt: json['dt_txt'], 
            main: json['main'] != null ? Main.fromJson(json['main']) : null,
            sys: json['sys'] != null ? Sys.fromJson(json['sys']) : null, 
            weather: json['weather'] != null ? (json['weather'] as List).map((i) => Weather.fromJson(i)).toList() : null, 
            wind: json['wind'] != null ? Wind.fromJson(json['wind']) : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['dt'] = this.dt;
        data['dt_txt'] = this.dt_txt;
        if (this.clouds != null) {
            data['clouds'] = this.clouds.toJson();
        }
        if (this.main != null) {
            data['main'] = this.main.toJson();
        }
        if (this.sys != null) {
            data['sys'] = this.sys.toJson();
        }
        if (this.weather != null) {
            data['weather'] = this.weather.map((v) => v.toJson()).toList();
        }
        if (this.wind != null) {
            data['wind'] = this.wind.toJson();
        }
        return data;
    }
}