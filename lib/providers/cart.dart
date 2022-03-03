import 'package:flutter/foundation.dart';

class CartItem {
  final String cartID;
  final String title;
  final int quant;
  final double price;
  final String imgUrl;
  final String nationality;

  //DateTime date;

  CartItem(
      {this.cartID,
      this.title,
      this.quant,
      this.price,
      this.imgUrl,
      this.nationality
      //@required this.date
      });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  Map<String, CartItem> _barbers = {};

  Map<String, CartItem> get barbers {
    return {..._barbers};
  }

  int get barberCounts {
    return barbers.length;
  }

  void addBarber(
      String barberId, String nationality, String imgUrl, String barberName) {
    if (barbers.containsKey(barberId)) {
      return;
    } else {
      _barbers.putIfAbsent(
        barberId,
        () => CartItem(
          cartID: DateTime.now().toString(),
          title: barberName,
          nationality: nationality,
          imgUrl: imgUrl,
        ),
      );
      print(barberId);
    }
    notifyListeners();
  }

  void removeBarber(String barberId) {
    _barbers.remove(barberId);
    notifyListeners();
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quant;
    });
    return total;
  }

  void addItem(
    String productID,
    double price,
    String title,
  ) {
    if (_items.containsKey(productID)) {
      // Change quant
      _items.update(
          productID,
          (existingCartItem) => CartItem(
              cartID: existingCartItem.cartID,
              title: existingCartItem.title,
              quant: existingCartItem.quant + 1,
              price: existingCartItem.price));
    } else {
      _items.putIfAbsent(
        productID,
        () => CartItem(
            cartID: DateTime.now().toString(),
            title: title,
            price: price,
            quant: 1),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    _barbers = {};
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey((productId))) {
      return;
    }
    if (_items[productId].quant > 1) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              cartID: existingCartItem.cartID,
              title: existingCartItem.title,
              price: existingCartItem.price,
              quant: existingCartItem.quant - 1));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void removeBarberUNDO(String barberID) {
    if (!_barbers.containsKey((barberID))) {
      return;
    } else {
      _barbers.remove(barberID);
    }
    notifyListeners();
  }
}
