import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_clock/Screens/auth_screen.dart';
import 'package:salon_clock/Screens/cart_screen.dart';
import 'package:salon_clock/Screens/edit_salons.dart';
import 'package:salon_clock/Screens/orders_screen.dart';
import 'package:salon_clock/Screens/salonOverviewScreen.dart';
import 'package:salon_clock/Screens/salon_detail_screen.dart';
import 'package:salon_clock/Screens/tap_screen.dart';
import 'package:salon_clock/Screens/user_salons_screen.dart';
import 'package:salon_clock/providers/auth.dart';
import 'package:salon_clock/providers/cart.dart';
import 'package:salon_clock/providers/orders.dart';
import 'package:salon_clock/providers/product.dart';
import 'package:salon_clock/providers/salon_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: SalonProvider(),
        ),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProvider.value(value: Orders())
      ],
      child: MaterialApp(
        title: 'SalonOclock',
        theme: ThemeData(primarySwatch: Colors.grey, accentColor: Colors.black),
        home: SalonOverviewScreen(),
        routes: {
          SalonDetailScreen.routeName: (ctx) => SalonDetailScreen(),
          TapScreen.routeName: (ctx) => TapScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserSalonScreen.routeName: (ctx) => UserSalonScreen(),
          EditSalonScreen.routeName: (ctx) => EditSalonScreen(),
        },
      ),
    );
  }
}
