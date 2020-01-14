import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/WeatherResponse.dart';
import 'package:weather_app/model/X.dart';
import 'package:weather_app/model/item_list_weather.dart';
import 'package:weather_app/ui/widget/header_swiper.dart';
import 'package:weather_app/ui/widget/item_swiper.dart';

class HomeScreen extends StatelessWidget {

  final WeatherResponse response;

  const HomeScreen({Key key, this.response}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _buildView(response)
    );
  }

  Widget _buildView(WeatherResponse response) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _buildHeader(response.list[0]),
          flex: 2,
        ),
        Expanded(
          child: _buildContent(response.getItem()),
          flex: 3,
        )
      ],
    );
  }

  Widget _buildHeader(X model) {
    var formatter = DateFormat('EEE, MMM d, yy');

    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              RichText(
                text: TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: 'Selamat ${_selectGreeting()},'),
                      TextSpan(text: ' ${response.name}')
                    ]
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: HeaderSwiper(model: model),
                    flex: 1,
                  ),
                  Expanded(
                    child: Container(
                      height: 180,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text('${response.city.name},'
                                '\n${formatter.format(DateTime.parse(response.list[0].dt_txt))}',
                                style: TextStyle(
                                  color: Colors.white
                                ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('${model.main.temp}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 42
                                ),
                              ),
                              Text('°C',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w100,
                                    fontSize: 20
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    flex: 1,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildContent(List<ItemListWeather> list) {
    var formatter = DateFormat('EEE, MMM d, yy');
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20.0),
        )
      ),
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Container(
            height: 60,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Text(formatter.format(DateTime.parse(list[index].date)),
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Center(
                    child: ItemListSwiper(list: list[index].list),
                  ),
                  flex: 1,
                )
              ],
            ),
          );
        }),
    );
  }

  String _selectGreeting() {
    var now = DateTime.now().hour;
    var param = (now/8).round();
    switch(param) {
      case 1 :
        return 'Pagi';
      case 2 :
        return 'Siang';
      case 3 :
        return 'Sore';
      case 4 :
        return 'Malam';
      default :
        return '';
    }
  }

}