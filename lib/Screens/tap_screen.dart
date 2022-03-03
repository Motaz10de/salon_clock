import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_clock/Screens/cart_screen.dart';
import 'package:salon_clock/Screens/salon_barbers_screen.dart';
import 'package:salon_clock/Screens/salon_detail_screen.dart';
import 'package:salon_clock/Screens/salon_services.dart';
import 'package:salon_clock/providers/cart.dart';
import 'package:salon_clock/providers/salon_provider.dart';
import 'package:salon_clock/providers/services.dart';
import 'package:salon_clock/widgets/badge.dart';

class TapScreen extends StatefulWidget {
  static const routeName = '/salon-detail';
  @override
  _TapScreenState createState() => _TapScreenState();
}

class _TapScreenState extends State<TapScreen> {
  @override
  Widget build(BuildContext context) {
    final salonId = ModalRoute.of(context).settings.arguments
        as String; // This is the ID of the salon
    final loadedSalons =
        Provider.of<SalonProvider>(context, listen: false).findById(salonId);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            title: Text(loadedSalons.title),
            actions: [
              Consumer<Cart>(
                builder: (_, cart, ch) =>
                    Badge(child: ch, value: cart.itemCount.toString()),
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                ),
              ),
            ],
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.category),
                  text: "Prodcuts",
                ),
                Tab(
                  icon: Icon(Icons.people),
                  text: "Barbers",
                ),
                Tab(
                  icon: Icon(CupertinoIcons.scissors),
                  text: "Services",
                )
              ],
            )),
        body: TabBarView(
            children: [SalonDetailScreen(), BarberScreen(), ServiceScreen()]),
      ),
    );
  }
}
