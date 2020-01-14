import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:weather_app/model/X.dart';
import 'package:weather_app/model/item_swiper.dart';

class HeaderSwiper extends StatelessWidget {
  final X model;
  List<ItemSwiper> list = List();

  HeaderSwiper({this.model}) {
    var itemList = this.model;

    for (var i = 0; i < 3; i++) {
      switch (i) {
        case 0 :
          list.add(
              ItemSwiper('http://openweathermap.org/img/wn/'
                  '${itemList.weather[0].icon}@2x.png',
                  itemList.weather[0].description));
          break;
        case 1 :
          list.add(ItemSwiper('assets/cloud.png',
              'kepekatan ${itemList.clouds.all}%'));
          break;
        case 2 :
          list.add(ItemSwiper('assets/wind.png',
              'kecepatan ${itemList.wind.speed} mil/jam'));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 180,
      child: Swiper(
        autoplay: true,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: index == 0?
                    CachedNetworkImage(
                      imageUrl: list[index].image,
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Image.asset(list[index].image),
                    ) :
                    Image.asset(list[index].image),
                  ),
                  flex: 3,
                ),
                Expanded(
                  child: Text(list[index].desc,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300
                    ),
                  ),
                  flex: 1,
                )
              ],
            ),
          );
        },
      ),
    );
  }

}