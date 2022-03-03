import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_clock/providers/Salon.dart';
import 'package:salon_clock/providers/cart.dart';
import 'package:salon_clock/providers/salon_provider.dart';

class ServiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final salonId = ModalRoute.of(context).settings.arguments as String;
    final loadedSalons =
        Provider.of<SalonProvider>(context, listen: false).findById(salonId);

    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          decoration:
              BoxDecoration(border: Border.all(width: 0.1, color: Colors.grey)),
          child: serviceScreen(loadedSalons, index, context),
        );
      },
      itemCount: loadedSalons.services.length,
    );
  }

  Card serviceScreen(Salon loadedSalons, int index, BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Card(
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: SizedBox(
            width: 120,
            height: 180,
            child: Image.network(
              loadedSalons.services[index].imageURL,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          loadedSalons.services[index].title +
              " - \$" +
              loadedSalons.services[index].price.toString(),
          style: const TextStyle(),
        ),
        subtitle: Text(loadedSalons.services[index].descrption),
        trailing: IconButton(
          //the child here inside the consumer will not be rebuild when the cart hcanges because its defind outside of the cart
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            cart.addItem(
                loadedSalons.services[index].serviceID,
                loadedSalons.services[index].price,
                loadedSalons.services[index].title);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                'Service Added To Cart!',
              ),
              duration: Duration(seconds: 2),
              action: SnackBarAction(
                label: 'Undo',
                textColor: Colors.blue,
                onPressed: () {
                  cart.removeSingleItem(loadedSalons.services[index].serviceID);
                },
              ),
            ));
          },
        ),
      ),
    );
  }
}
