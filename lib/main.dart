import 'package:flutter/material.dart';
import 'package:weather_app/ui/boarding_screen.dart';
import 'package:weather_app/ui/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BoardingScreen(),
    );
  }
}
