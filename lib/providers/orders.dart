import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:salon_clock/providers/cart.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final List<CartItem> barbers;
  final DateTime dateTime;
  final DateTime bookingTime;
  final String orderTime;

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
  final String authToken;

  Orders(this.authToken, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url =
        'https://test11-eb4c6-default-rtdb.firebaseio.com/orders.json?auth=$authToken';
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          bookingTime: DateTime.parse(orderData['bookingTime']),
          orderTime: orderData['orderTime'],
          products: (orderData['products'] as List<dynamic>)
              .map((item) => CartItem(
                  cartID: item['id'],
                  price: item['price'],
                  quant: item['quantity'],
                  title: item['title']))
              .toList(),
          barbers: (orderData['barbers'] as List<dynamic>)
              .map((item) => CartItem(title: item['barberName']))
              .toList(),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(
      List<CartItem> cartProducts,
      List<CartItem> barbers,
      double total,
      DateTime bookingTime,
      String orderTime,
      BuildContext context) async {
    final url =
        'https://test11-eb4c6-default-rtdb.firebaseio.com/orders.json?auth=$authToken';
    final timeStamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'bookingTime': bookingTime.toIso8601String(),
          'orderTime': orderTime,
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
