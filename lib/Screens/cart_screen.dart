import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_clock/Screens/orders_screen.dart';
import 'package:salon_clock/providers/cart.dart' show Cart;
import 'package:salon_clock/providers/orders.dart';
import 'package:salon_clock/widgets/cart_item.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DateTime _selectDate;
  TimeOfDay _timeOfDay = TimeOfDay.now();
  @override
  void initState() {
    // TODO: implement initState
    _selectDate = DateTime.now();
    _timeOfDay = TimeOfDay.now();
    super.initState();
  }

  @override
  void _presentDataPicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2023))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectDate = pickedDate;
      });
    }); //then is a value that allow us to provide a function once that the user choose the date:)
  }

  void _showTimePicker() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((pickedTime) {
      if (pickedTime == null) {
        return;
      }
      setState(() {
        _timeOfDay = pickedTime;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
        actions: [
          IconButton(
              onPressed: _presentDataPicker,
              icon: const Icon(Icons.calendar_today)),
          IconButton(
              onPressed: _showTimePicker, icon: const Icon(Icons.more_time))
        ],
      ),
      body: Column(
        children: [
          Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined),
                    Text(DateFormat.yMMMd().format(_selectDate))
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.watch_later),
                    Text(_timeOfDay.format(context).toString())
                  ],
                ),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline6
                              .color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  orderButton(
                      cart: cart,
                      selectDate: _selectDate,
                      timeOfDay: _timeOfDay)
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) => CartItem(
              id: cart.items.values.toList()[index].cartID,
              title: cart.items.values.toList()[index].title,
              quantity: cart.items.values.toList()[index].quant,
              price: cart.items.values.toList()[index].price,
              productId: cart.items.keys.toList()[index],
            ),
            itemCount: cart.items.length,
          )),
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: ListView.builder(
              itemBuilder: (context, index) => CartBarberItems(
                id: cart.barbers.values.toList()[index].cartID,
                barberId: cart.barbers.keys.toList()[index],
                name: cart.barbers.values.toList()[index].title,
                imageUrl: cart.barbers.values.toList()[index].imgUrl,
                nationality: cart.barbers.values.toList()[index].nationality,
              ),
              itemCount: cart.barbers.length,
            ),
          )
        ],
      ),
    );
  }

  CartBarberItems(
      {String id,
      String barberId,
      String name,
      String imageUrl,
      String nationality}) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Card(
      child: ListTile(
        title: Text(name),
        subtitle: Text(nationality),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            width: 50,
            height: 50,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () {
            cart.removeBarber(barberId);
          },
        ),
      ),
    );
  }
}

class orderButton extends StatefulWidget {
  const orderButton({
    Key key,
    @required this.cart,
    @required DateTime selectDate,
    @required TimeOfDay timeOfDay,
  })  : _selectDate = selectDate,
        _timeOfDay = timeOfDay,
        super(key: key);

  final Cart cart;
  final DateTime _selectDate;
  final TimeOfDay _timeOfDay;

  @override
  State<orderButton> createState() => _orderButtonState();
}

class _orderButtonState extends State<orderButton> {
  var _isloading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: (widget.cart.totalAmount <= 0 || _isloading)
            ? null
            : () async {
                setState(() {
                  _isloading = true;
                });
                await Provider.of<Orders>(context, listen: false).addOrder(
                    widget.cart.items.values.toList(),
                    widget.cart.barbers.values.toList(),
                    widget.cart.totalAmount,
                    widget._selectDate,
                    widget._timeOfDay);
                setState(() {
                  _isloading = false;
                });
                widget.cart.clearCart();
                Navigator.of(context)
                    .pushReplacementNamed(OrdersScreen.routeName);
              },
        child: _isloading
            ? const CircularProgressIndicator()
            : const Text("Order Now"));
  }
}
