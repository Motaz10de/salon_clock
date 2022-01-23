// ignore_for_file: file_names
import 'package:flutter/foundation.dart';

class Salon {
  final String id;
  final String title;
  final String description;
  final String phoneNo;
  final String imageLogo;
  //final String location; // Change
  final String locationDesc;
  bool isFavorite;
  bool gender;
  Salon(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.phoneNo,
      @required this.imageLogo,
      @required this.locationDesc,
      this.isFavorite = false,
      this.gender = false});
}
