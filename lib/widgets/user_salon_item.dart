import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_clock/Screens/edit_salons.dart';
import 'package:salon_clock/providers/salon_provider.dart';

class UserSalonItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserSalonItem(this.title, this.imageUrl, this.id);
  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          imageUrl,
        ),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditSalonScreen.routeName, arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                try {
                  await Provider.of<SalonProvider>(context, listen: false)
                      .deleteSalon(id);
                } catch (error) {
                  scaffold.showSnackBar(const SnackBar(
                      content: Text(
                    "Deleting Failed!",
                    textAlign: TextAlign.center,
                  )));
                }
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
