import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_clock/providers/orders.dart' show Orders;
import 'package:salon_clock/widgets/app_drawrer.dart';
import 'package:salon_clock/widgets/order_items.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Orders"),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (context, index) => OrderItem(orderData.orders[index]),
        itemCount: orderData.orders.length,
      ),
    );
  }
}
