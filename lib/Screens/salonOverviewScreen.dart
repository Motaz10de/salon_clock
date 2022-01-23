// ignore_for_file: use_key_in_widget_constructors, file_names

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:salon_clock/widgets/salon_element.dart';

import '../models/Salon.dart';

class SalonOverviewScreen extends StatelessWidget {
  final List<Salon> _loadedSalons = [
    Salon(
        id: "1",
        title: "Turkish",
        description: "for the good guys only",
        phoneNo: "+966-555555555",
        imageLogo:
            "https://static.wixstatic.com/media/59ee53_91785d95deeb4e67b3309b7add63173f~mv2_d_1500_1225_s_2.jpg/v1/fit/w_2500,h_1330,al_c/59ee53_91785d95deeb4e67b3309b7add63173f~mv2_d_1500_1225_s_2.jpg",
        locationDesc: "jeddah - albawadi - anis alaslmi street"),
    Salon(
        id: "2",
        title: "Albaha Style",
        description: "Ghamdi Is Gentel",
        phoneNo: "+966-535476264",
        imageLogo:
            "https://png.pngtree.com/png-vector/20190528/ourlarge/pngtree-black-and-white-barber-shop-logo-png-image_1111113.jpg",
        locationDesc: "ِAlbaha - Aljadia - Mohammad AlAslami street"),
    Salon(
        id: "3",
        title: "Ladies Beauty",
        description: "Make your wife beautiful again!",
        phoneNo: "+966-546278889",
        imageLogo:
            "https://d2zdpiztbgorvt.cloudfront.net/region1/us/1278d547dcb249f28c441db7c4a2a038/405778-Moonlight-Beauty-Salon.jpeg",
        locationDesc: "ِAlbaha - Aljadia - Mohammad AlAslami street"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                'assets/images/MyLogo.png',
                fit: BoxFit.cover,
              )),
        ),
        title: const Text("SALON O'CLOCK",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ), //Oi
        itemBuilder: (context, index) => SalonElement(
            _loadedSalons[index].id,
            _loadedSalons[index].title,
            _loadedSalons[index].imageLogo,
            _loadedSalons[index].locationDesc),
        itemCount: _loadedSalons.length,
      ),
    );
  }
}
