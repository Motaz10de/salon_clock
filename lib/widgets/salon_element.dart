import 'package:flutter/material.dart';

class SalonElement extends StatelessWidget {
  final String id;
  final String title;
  final String imageLogo;
  final String locationDesc;
  SalonElement(
    this.id,
    this.title,
    this.imageLogo,
    this.locationDesc,
  );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: GridTile(
        child: Image.network(
          imageLogo,
          fit: BoxFit.cover,
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
          trailing:
              IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
          subtitle: Text(
            locationDesc,
            softWrap: true,
          ),
        ),
      ),
    );
  }
}
