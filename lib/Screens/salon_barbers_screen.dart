import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_clock/providers/salon_provider.dart';
import 'package:salon_clock/widgets/barber_element.dart';
import 'package:salon_clock/widgets/salon_element.dart';

class BarberScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final salonId = ModalRoute.of(context).settings.arguments as String;
    final loadedSalons =
        Provider.of<SalonProvider>(context, listen: false).findById(salonId);
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: loadedSalons.barbers[index],
        child: BarberElement(),
      ),
      itemCount: loadedSalons.barbers.length,
    );
  }
}
