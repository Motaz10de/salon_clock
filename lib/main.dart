import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_clock/Screens/authentication_screen.dart';
import 'package:salon_clock/Screens/cart_screen.dart';
import 'package:salon_clock/Screens/edit_salons.dart';
import 'package:salon_clock/Screens/orders_screen.dart';
import 'package:salon_clock/Screens/salonOverviewScreen.dart';
import 'package:salon_clock/Screens/salon_detail_screen.dart';
import 'package:salon_clock/Screens/start_screen.dart';
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
        ChangeNotifierProxyProvider<Auth, SalonProvider>(
          update: (ctx, auth, previousProducts) => SalonProvider(
              auth.token,
              auth.userId,
              previousProducts == null ? [] : previousProducts.items),
        ),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProxyProvider<Auth, Orders>(
            update: (ctx, auth, previousOrders) => Orders(
                auth.token,
                auth.userId,
                previousOrders == null ? [] : previousOrders.orders))
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'SalonOclock',
          theme:
              ThemeData(primarySwatch: Colors.grey, accentColor: Colors.black),
          home: auth.isAuth ? SalonOverviewScreen() : Start_screen(),
          routes: {
            SalonDetailScreen.routeName: (ctx) => SalonDetailScreen(),
            TapScreen.routeName: (ctx) => TapScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserSalonScreen.routeName: (ctx) => UserSalonScreen(),
            EditSalonScreen.routeName: (ctx) => EditSalonScreen(),
          },
        ),
      ),
    );
  }
}
