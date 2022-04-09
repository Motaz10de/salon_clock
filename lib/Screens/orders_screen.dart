import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_clock/providers/orders.dart' show Orders;
import 'package:salon_clock/widgets/app_drawrer.dart';
import 'package:salon_clock/widgets/order_items.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    print("building orders");
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Orders"),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
            future:
                Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
            builder: (ctx, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (dataSnapshot.error != null) {
                  //Do error
                  return const Center(
                    child: Text("An Error Occurred!"),
                  );
                } else {
                  return Consumer<Orders>(
                    builder: (ctx, orderData, child) => ListView.builder(
                      itemBuilder: (context, index) =>
                          OrderItem(orderData.orders[index]),
                      itemCount: orderData.orders.length,
                    ),
                  );
                }
              }
            }));
  }
}
