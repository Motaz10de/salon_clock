import 'package:flutter/material.dart';
import 'package:salon_clock/Screens/orders_screen.dart';
import 'package:salon_clock/Screens/user_salons_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("Salon O'Clock"),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
              leading: Icon(Icons.shop),
              title: Text("Shop"),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.payment),
              title: Text("Orders"),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(OrdersScreen.routeName);
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.edit),
              title: Text("Manage Your Salons"),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(UserSalonScreen.routeName);
              }),
        ],
      ),
    );
  }
}
