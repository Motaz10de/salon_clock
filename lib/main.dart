import 'package:flutter/material.dart';
import 'package:salon_clock/Screens/salonOverviewScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SalonOclock',
      theme: ThemeData(primarySwatch: Colors.grey, accentColor: Colors.black),
      home: SalonOverviewScreen(),
    );
  }
}
