import 'package:flutter/cupertino.dart';

class Services with ChangeNotifier {
  final String serviceID;
  final String title;
  final double price;
  final String imageURL;
  final String descrption;

  Services(
      {this.serviceID, this.title, this.price, this.imageURL, this.descrption});
}
