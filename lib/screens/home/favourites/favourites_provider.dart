import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_hub/models/cart.dart';
import 'package:watch_hub/screens/home/favourites/favourites_list.dart';
import 'package:watch_hub/services/database.dart';

class FavouritesProvider extends StatefulWidget {
  const FavouritesProvider({super.key});

  @override
  State<FavouritesProvider> createState() => _FavouritesProviderState();
}

class _FavouritesProviderState extends State<FavouritesProvider> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Cart>>.value(
      value: DatabaseService().favourites,
      initialData: const [],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 22, 69, 169),
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: const Text(
            "Wishlist",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor:const Color.fromARGB(255, 253, 249, 246),
        body: const FavouritesList(),
      ),
    );
  }
}
