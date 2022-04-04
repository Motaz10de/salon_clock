import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:salon_clock/providers/cart.dart';
import 'package:http/http.dart' as http;

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
      double total, DateTime bookingTime, TimeOfDay orderTime) async {
    const url = 'https://test11-eb4c6-default-rtdb.firebaseio.com/orders.json';
    final timeStamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'bookingTime': bookingTime.toIso8601String(),
          'orderTime': orderTime.toString(),
          'products': cartProducts
              .map(
                (cp) => {
                  'id': cp.cartID,
                  'title': cp.title,
                  'quantity': cp.quant,
                  'price': cp.price
                },
              )
              .toList(),
          'barbers': barbers.map((br) => {'barberName': br.title}).toList()
        }));
    _orders.insert(
        0,
        OrderItem(
            id: json.decode(response.body)['name'],
            amount: total,
            dateTime: timeStamp,
            products: cartProducts,
            barbers: barbers,
            bookingTime: bookingTime,
            orderTime: orderTime));
    notifyListeners();
  }
}
