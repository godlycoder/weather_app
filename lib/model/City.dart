
import 'Coord.dart';

class City {
    Coord coord;
    String country;
    int id;
    String name;

    City({this.coord, this.country, this.id, this.name});

    factory City.fromJson(Map<String, dynamic> json) {
        return City(
            coord: json['coord'] != null ? Coord.fromJson(json['coord']) : null, 
            country: json['country'], 
            id: json['id'], 
            name: json['name'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['country'] = this.country;
        data['id'] = this.id;
        data['name'] = this.name;
        if (this.coord != null) {
            data['coord'] = this.coord.toJson();
        }
        return data;
    }
}