import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_clock/Screens/salon_detail_screen.dart';
import 'package:salon_clock/Screens/tap_screen.dart';
import 'package:salon_clock/providers/Salon.dart';
import 'package:salon_clock/providers/cart.dart';

class SalonElement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final salon = Provider.of<Salon>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(TapScreen.routeName, arguments: salon.id);
          },
          child: Image.network(
            salon.imageLogo,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              salon.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          trailing: IconButton(
              onPressed: () {
                salon.toggleFavoriteStatus();
              },
              icon: Icon(
                  salon.isFavorite ? (Icons.favorite) : Icons.favorite_border)),
          subtitle: Text(
            salon.locationDesc,
            softWrap: true,
          ),
        ),
      ),
    );
  }
}
