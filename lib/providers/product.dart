import 'package:flutter/material.dart';

class ProductItem with ChangeNotifier {
  final String productID;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;
  ProductItem(
      {@required this.productID,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite = false});
}

class Product with ChangeNotifier {
  final Map<String,ProductItem > _items =
      {}; //? The string in Map<String, CartItem> is the id of the product.
  Map<String,ProductItem > get items {
    // this getter will return a copy of the cart
    return {..._items};
  }
}
