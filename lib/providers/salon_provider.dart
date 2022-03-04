import 'package:flutter/material.dart';
import 'package:salon_clock/providers/Salon.dart';
import 'package:salon_clock/providers/barbers.dart';
import 'package:salon_clock/providers/product.dart';
import 'package:salon_clock/providers/services.dart';

class SalonProvider with ChangeNotifier {
  final List<Salon> _items = [
    Salon(
        id: "1",
        title: "Turkish",
        description:
            "Located at Twin Park’s Centre, Lucinda’s Hair & Beauty salon provides you a range of highly trendy hair cuts and styling, makeup, hair coloring, waxing services, spray tanning and facials. It was established in the year 2005 and has a team of highly skilled and experienced stylists.",
        phoneNo: "+966-555555555",
        imageLogo:
            "https://static.wixstatic.com/media/59ee53_91785d95deeb4e67b3309b7add63173f~mv2_d_1500_1225_s_2.jpg/v1/fit/w_2500,h_1330,al_c/59ee53_91785d95deeb4e67b3309b7add63173f~mv2_d_1500_1225_s_2.jpg",
        locationDesc: "jeddah - albawadi - anis alaslmi street",
        products: [
          ProductItem(
              productID: "1",
              title: "Shampoo",
              description: "this is a shampoo",
              price: 29.99,
              imageUrl:
                  "https://www.tresemme.com/content/dam/unilever/tresemme/united_states_of_america/pack_shot/022400393650.01-2315619-png.png"),
          ProductItem(
              productID: "2",
              title: "Hair Gel",
              description:
                  "hairstyling product that is used to harden hair into a particular hairstyle.",
              price: 39.99,
              imageUrl: "https://m.media-amazon.com/images/I/81mJ-8x8q-L.jpg"),
          ProductItem(
              productID: "3",
              title: "Facial Mask",
              description: "Useful for having a clear skin!",
              price: 19.99,
              imageUrl:
                  "https://media.allure.com/photos/5fd10e4c74a4007dbcca6e33/1:1/w_1000,h_1000,c_limit/Paula's%20Choice%20Super%20Hydrate%20Overnight%20Mask.jpg"),
        ],
        barbers: [
          Barbers(
            barberID: "7",
            name: "Naweed Khan",
            nationality: "Indian",
            career: "A barber cuts and styles their clients' hair.",
            imageURL:
                "https://images.squarespace-cdn.com/content/v1/5c4fed1c2487fd1815bfbc8b/1549191113837-21XN4ACZ4VK1ENWDA7YG/best_barber_shop_fitzroy.png",
          ),
          Barbers(
            barberID: "8",
            name: "Asaf Hakeem",
            nationality: "Pakstani",
            career: "Pakstani is NOT afraid!",
            imageURL:
                "https://i1.rgstatic.net/ii/profile.image/880494057111554-1586937550690_Q512/Asaf-Khan-8.jpg",
          ),
          Barbers(
            barberID: "9",
            name: "Fawzi Bahjat",
            nationality: "Egyptian",
            career: "From the mother of the world!!",
            imageURL:
                "https://media.gemini.media/img/large/2018/5/29/2018_5_29_12_6_55_554.jpg",
          ),
          Barbers(
            barberID: "10",
            name: "Giorno Giovanna",
            nationality: "Italian",
            career: "The best in Europe!",
            imageURL:
                "https://preview.redd.it/86mt1ze71m181.png?width=500&format=png&auto=webp&s=0bc18a6af36fede0af091c7c68877cc7e64bf5e2",
          ),
        ],
        services: [
          Services(
              serviceID: "4",
              title: "Haircut",
              descrption: "a fancy haircut for fancy men",
              imageURL:
                  "https://i.insider.com/577690414321f1f9148b56a9?width=1000&format=jpeg&auto=webp",
              price: 19.99),
          Services(
              serviceID: "5",
              title: "Beardcut",
              descrption: "Null for now",
              imageURL:
                  "https://img.dtcn.com/image/themanual/stock-beard-trimming.jpg",
              price: 15.99),
          Services(
              serviceID: "6",
              title: "Facemask",
              descrption: "Null for now",
              imageURL:
                  "https://media.istockphoto.com/photos/beauty-salon-the-beautician-puts-a-black-mask-on-the-mans-face-with-a-picture-id1073288842",
              price: 10.99),
        ]),
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
  var _showFavoritesOnly = false;

  List<Salon> get items {
    return [..._items];
  }

  List<Salon> get favoritesItem {
    return _items.where((salonItem) => salonItem.isFavorite).toList();
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  void addSalon(Salon salon) {
    final newSalon = Salon(
        title: salon.title,
        description: salon.description,
        locationDesc: salon.locationDesc,
        phoneNo: salon.phoneNo,
        imageLogo: salon.imageLogo,
        id: DateTime.now().toString());
    _items.add(newSalon);
    notifyListeners();
    //This for adding a salon in the future.
  }

  Salon findById(String id) {
    return _items.firstWhere((slon) => slon.id == id);
  }

  void updateSalon(String id, Salon updatedSalon) {
    final salonIndex = _items.indexWhere((salon) => salon.id == id);
    if (salonIndex >= 0) {
      _items[salonIndex] = updatedSalon;
      notifyListeners();
    } else {
      print("ERROR");
    }
  }
}
