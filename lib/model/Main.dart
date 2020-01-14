

class Main {
    int grnd_level;
    int humidity;
    int pressure;
    int sea_level;
    dynamic temp;
    dynamic temp_kf;
    dynamic temp_max;
    dynamic temp_min;

    Main({this.grnd_level, this.humidity, this.pressure, this.sea_level, this.temp, this.temp_kf, this.temp_max, this.temp_min});

    factory Main.fromJson(Map json) {
        return Main(
            grnd_level: json['grnd_level'], 
            humidity: json['humidity'], 
            pressure: json['pressure'], 
            sea_level: json['sea_level'], 
            temp: json['temp'],
            temp_kf: json['temp_kf'],
            temp_max: json['temp_max'],
            temp_min: json['temp_min'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['grnd_level'] = this.grnd_level;
        data['humidity'] = this.humidity;
        data['pressure'] = this.pressure;
        data['sea_level'] = this.sea_level;
        data['temp'] = this.temp;
        data['temp_kf'] = this.temp_kf;
        data['temp_max'] = this.temp_max;
        data['temp_min'] = this.temp_min;
        return data;
    }
}