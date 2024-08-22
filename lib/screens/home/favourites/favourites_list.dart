import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_hub/models/cart.dart';
import 'package:watch_hub/services/database.dart';

class GetPrice {
  static num? price = 0;
  static int quantity = 0;
  static List carts = [];
}

class FavouritesList extends StatefulWidget {
  const FavouritesList({super.key});

  @override
  State<FavouritesList> createState() => _FavouritesListState();
}

class _FavouritesListState extends State<FavouritesList> {
  static int? price;
  @override
  Widget build(BuildContext context) {
    final favourite = Provider.of<List<Cart>>(context);

    List totalPriceList = [];
    int totalQuantity;
    // cart.sort();

    return favourite.isEmpty
        ? Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(
                  height: 300,
                  'https://firebasestorage.googleapis.com/v0/b/watch-hub-6810e.appspot.com/o/not-found-removebg-preview.png?alt=media&token=c98edcd3-07e1-4016-b510-a34bdd687fae'),
              const Text(
                "No Favourite Watches",
                style: TextStyle(fontSize: 30.0),
              )
            ],
          ))
        : ListView.builder(
            itemCount: favourite.length,
            itemBuilder: (
              context,
              index,
            ) {
              int totalQuantity =
                  favourite[index].price! * favourite[index].quantity!;
              return Column(
                children: [
                  Container(
                      // height: 50,
                      child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              favourite[index].image!,
                            ),
                          ),
                          title: Text(
                            "${favourite[index].model!}(${favourite[index].quantity})",
                            style: const TextStyle(fontSize: 20),
                          ),
                          subtitle: Text(
                            "\$${favourite[index].price.toString()}",
                            style: const TextStyle(fontSize: 20),
                          ),
                          trailing: FutureBuilder(
                            future: DatabaseService()
                                .getCartBool(favourite[index].model!),
                            builder: (context, snapshot) => snapshot.data ==
                                    true
                                ? TextButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        side: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 139, 185, 255),
                                        ),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)))),
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/cart');
                                    },
                                    child: const Text(
                                      "Added To Cart",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 139, 185, 255)),
                                    ),
                                  )
                                : TextButton(
                                    onPressed: () async {
                                      await DatabaseService().addToCart(
                                          favourite[index].model!,
                                          favourite[index].brand!,
                                          favourite[index].quantity!,
                                          favourite[index].price!,
                                          favourite[index].image!);
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: const Text("Watch Hub"),
                                                content:
                                                    const Text("Added To Cart"),
                                                contentPadding:
                                                    EdgeInsets.all(20.0),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child:
                                                          (const Text("Close")))
                                                ],
                                              ));
                                      setState(() {});
                                    },
                                    style: TextButton.styleFrom(
                                        backgroundColor:
                                            Color.fromARGB(255, 139, 185, 255),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)))),
                                    child: const Text(
                                      "Add To Cart",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                          )
                          // Text(
                          //   "fff",
                          //   style: const TextStyle(fontSize: 20),
                          // ),
                          )),
                  Divider()
                ],
              );
            });
  }
}
