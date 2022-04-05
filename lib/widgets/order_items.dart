import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import '../providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount.toStringAsFixed(2)}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Order Date: " +
                    DateFormat('dd/MM/yyyy hh:mm')
                        .format(widget.order.dateTime)),
                Text("Booking Date: " +
                    DateFormat('dd/MM/yyyy').format(widget.order.bookingTime)),
                Text("Booking Time: " +
                    (widget.order.orderTime.toString()).toString()),
              ],
            ),
            trailing: IconButton(
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more)),
          ),
          if (_expanded)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: Column(
                children: [
                  Container(
                    height:
                        min(widget.order.products.length * 20.0 + 10.0, 180.0),
                    child: ListView(
                      children: widget.order.products
                          .map((prod) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    prod.title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    '${prod.quant}x \$${prod.price.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.grey),
                                  ),
                                ],
                              ))
                          .toList(),
                    ),
                  ),
                  Container(
                      height:
                          min(widget.order.products.length * 9.0 + 10.0, 180.0),
                      child: ListView(
                          children: widget.order.barbers
                              .map((barber) => Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Barbers Choosen: " + barber.title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ))
                              .toList()))
                ],
              ),
            )
        ],
      ),
    );
  }
}
