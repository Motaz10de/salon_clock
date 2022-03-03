import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:salon_clock/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final List<CartItem> barbers;
  final DateTime dateTime;
  final DateTime bookingTime;
  final TimeOfDay orderTime;

  OrderItem(
      {this.id,
      this.amount,
      this.products,
      this.barbers,
      this.dateTime,
      this.bookingTime,
      this.orderTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, List<CartItem> barbers,
      double total, DateTime bookingTime, TimeOfDay orderTime) {
    _orders.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            amount: total,
            dateTime: DateTime.now(),
            products: cartProducts,
            barbers: barbers,
            bookingTime: bookingTime,
            orderTime: orderTime));
    notifyListeners();
  }
}
