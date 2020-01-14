import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:weather_app/model/Weather.dart';

class ItemListSwiper extends StatelessWidget {
  final List<Weather> list;

  ItemListSwiper({this.list});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 50,
      child: Swiper(
        autoplay: true,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Row(
            children: <Widget>[
              Text(list[index].hour),
              CachedNetworkImage(
                imageUrl: 'http://openweathermap.org/img/wn/'
                    '${list[index].icon}@2x.png',
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              )
            ],
          );
        },
      ),
    );
  }

}