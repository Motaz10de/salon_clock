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
  var _isInitiated = true;
  var _isLoading = false;
  @override
  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts(); THIS WONT WORK!
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: didChangeDependencies  this will now run after the widget has been fully initialized so to say but before build ran for the first time.
    // It will, however, unlike initState, run more often multiple times and not just when this gets created.
    if (_isInitiated) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<SalonProvider>(context).fetchAndSetSalons().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInitiated = false;
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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SalonGrid(_showOnlyFavorites),
    );
  }
}
