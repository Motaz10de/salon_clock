import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_clock/providers/salon_provider.dart';
import 'package:salon_clock/widgets/salon_element.dart';

class SalonGrid extends StatelessWidget {
  final bool showFav;
  SalonGrid(this.showFav);
  @override
  Widget build(BuildContext context) {
    final salonData = Provider.of<SalonProvider>(context);
    final salons = showFav ? salonData.favoritesItem : salonData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ), //Oi
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: salons[index],
        child: SalonElement(),
      ),
      itemCount: salons.length,
    );
  }
}
