import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_clock/providers/Salon.dart';
import 'package:salon_clock/providers/cart.dart';
import 'package:salon_clock/providers/product.dart';
import 'package:salon_clock/providers/salon_provider.dart';

class SalonDetailScreen extends StatelessWidget {
  static const routeName = '/salon-detail';
  @override
  Widget build(BuildContext context) {
    final salonId = ModalRoute.of(context).settings.arguments
        as String; // This is the ID of the salon
    final loadedSalons =
        Provider.of<SalonProvider>(context, listen: false).findById(salonId);
    final cart = Provider.of<Cart>(context, listen: false);

    return Column(
      children: [
        Container(
          decoration:
              BoxDecoration(border: Border.all(width: 0.3, color: Colors.grey)),
          height: 250,
          width: double.infinity,
          child: Image.network(
            loadedSalons.imageLogo,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                loadedSalons.title,
                style:
                    const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              Text(loadedSalons.phoneNo,
                  style: const TextStyle(
                      fontSize: 23, fontWeight: FontWeight.bold))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              loadedSalons.description,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ),
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 0.1, color: Colors.grey)),
              child: productScreen(loadedSalons, index, context),
            );
          },
          itemCount: loadedSalons.products.length,
        )),
      ],
    );
  }

//----------------------------------------------------------------------------------
  Card productScreen(Salon loadedSalons, int index, BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Card(
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            width: 50,
            height: 50,
            child: Image.network(
              loadedSalons.products[index].imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          loadedSalons.products[index].title +
              " - \$" +
              loadedSalons.products[index].price.toString(),
          style: const TextStyle(),
        ),
        subtitle: Text(loadedSalons.products[index].description),
        trailing: IconButton(
          //the child here inside the consumer will not be rebuild when the cart hcanges because its defind outside of the cart
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            cart.addItem(
                loadedSalons.products[index].productID,
                loadedSalons.products[index].price,
                loadedSalons.products[index].title);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                'Product Added To Cart!',
              ),
              duration: Duration(seconds: 2),
              action: SnackBarAction(
                label: 'Undo',
                textColor: Colors.blue,
                onPressed: () {
                  cart.removeSingleItem(loadedSalons.products[index].productID);
                },
              ),
            ));
          },
        ),
      ),
    );
  }
}
