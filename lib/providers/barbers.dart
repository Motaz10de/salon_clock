import 'package:flutter/cupertino.dart';

class Barbers with ChangeNotifier {
  final String barberID;
  final String name;
  final String nationality;
  final String imageURL;
  final String career;

  Barbers(
      {this.barberID, this.name, this.nationality, this.imageURL, this.career});
}
