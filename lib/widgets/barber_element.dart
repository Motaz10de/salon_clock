import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:salon_clock/Screens/salon_detail_screen.dart';
import 'package:salon_clock/Screens/tap_screen.dart';
import 'package:salon_clock/providers/Salon.dart';
import 'package:salon_clock/providers/barbers.dart';
import 'package:salon_clock/providers/cart.dart';

class BarberElement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final barber = Provider.of<Barbers>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: GridTile(
        child: Image.network(
          barber.imageURL,
          fit: BoxFit.cover,
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Text(
              barber.name,
              softWrap: true,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          subtitle: Text(
            barber.nationality,
            softWrap: true,
            style: const TextStyle(color: Colors.white, fontSize: 11),
          ),
          trailing: IconButton(
              onPressed: () {
                cart.addBarber(barber.barberID, barber.nationality,
                    barber.imageURL, barber.name);
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                    'Barber Has Been Chosen!',
                  ),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'Undo',
                    textColor: Colors.blue,
                    onPressed: () {
                      cart.removeBarberUNDO(barber.barberID);
                    },
                  ),
                ));
              },
              icon: const Icon(Icons.add)),
        ),
      ),
    );
  }
}
