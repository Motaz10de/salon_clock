import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_clock/Screens/orders_screen.dart';
import 'package:salon_clock/Screens/user_salons_screen.dart';
import 'package:salon_clock/providers/auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text("Salon O'Clock"),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.shop),
              title: const Text("Shop"),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              }),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.payment),
              title: Text("Orders"),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(OrdersScreen.routeName);
              }),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.edit),
              title: const Text("Manage Your Salons"),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(UserSalonScreen.routeName);
              }),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Log Out"),
              onTap: () {
                Navigator.of(context).pop();
                // Navigator.of(context)
                //     .pushReplacementNamed(UserSalonScreen.routeName);
                Provider.of<Auth>(context, listen: false).logOut();
              }),
        ],
      ),
    );
  }
}
