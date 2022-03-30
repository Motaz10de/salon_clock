// ignore_for_file: use_key_in_widget_constructors, file_names

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_clock/providers/cart.dart';
import 'package:salon_clock/providers/salon_provider.dart';
import 'package:salon_clock/widgets/app_drawrer.dart';
import 'package:salon_clock/widgets/badge.dart';

import 'package:salon_clock/widgets/salon_grid.dart';

import 'cart_screen.dart';

enum FilterOption {
  Favorites,
  All,
}

class SalonOverviewScreen extends StatefulWidget {
  @override
  State<SalonOverviewScreen> createState() => _SalonOverviewScreenState();
}

class _SalonOverviewScreenState extends State<SalonOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;

  @override
  void initState() {
    //Provider.of<SalonProvider>(context).fetchAndSetSalons(); // WONT WORK
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<SalonProvider>(context).fetchAndSetSalons();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<SalonProvider>(context).fetchAndSetSalons();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: const Text("SALON O'CLOCK",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          PopupMenuButton(
              onSelected: (FilterOption selectedValue) {
                setState(() {
                  if (selectedValue == FilterOption.Favorites) {
                    _showOnlyFavorites = true;
                  } else {
                    _showOnlyFavorites = false;
                  }
                });
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    const PopupMenuItem(
                      child: Text("Only Favorites"),
                      value: FilterOption.Favorites,
                    ),
                    const PopupMenuItem(
                      child: Text("Show All"),
                      value: FilterOption.All,
                    ),
                  ]),
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
      ),
      drawer: AppDrawer(),
      body: SalonGrid(_showOnlyFavorites),
    );
  }
}
