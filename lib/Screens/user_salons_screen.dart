import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_clock/Screens/edit_salons.dart';
import 'package:salon_clock/providers/salon_provider.dart';
import 'package:salon_clock/widgets/app_drawrer.dart';
import 'package:salon_clock/widgets/user_salon_item.dart';

class UserSalonScreen extends StatelessWidget {
  static const routeName = '/user-salons';
  @override
  Widget build(BuildContext context) {
    final salonsData = Provider.of<SalonProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Salons'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditSalonScreen.routeName);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshSalons(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: salonsData.items.length,
            itemBuilder: (_, index) => Column(
              children: [
                UserSalonItem(
                    salonsData.items[index].title,
                    salonsData.items[index].imageLogo,
                    salonsData.items[index].id),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _refreshSalons(BuildContext context) async {
    await Provider.of<SalonProvider>(context, listen: false)
        .fetchAndSetSalons();
  }
}
