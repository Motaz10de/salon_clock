// ignore_for_file: file_names
import 'package:flutter/foundation.dart';
import 'package:salon_clock/providers/barbers.dart';
import 'package:salon_clock/providers/product.dart';
import 'package:salon_clock/providers/services.dart';

class Salon with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String phoneNo;
  final String imageLogo;
  //final String location; // Change
  final String locationDesc;
  bool isFavorite;
  bool gender;
  final List<ProductItem> products;
  final List<Barbers> barbers;
  final List<Services> services;

  Salon(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.phoneNo,
      @required this.imageLogo,
      @required this.locationDesc,
      @required this.products,
      @required this.barbers,
      @required this.services,
      this.isFavorite = false,
      this.gender = false});

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
