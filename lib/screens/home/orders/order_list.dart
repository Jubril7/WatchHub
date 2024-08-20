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

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  static int? price;
  @override
  Widget build(BuildContext context) {
    final order = Provider.of<List<Cart>>(context);

    List totalPriceList = [];
    int totalQuantity;
    // cart.sort();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 22, 69, 169),
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text(
          "Orders",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: order.isEmpty
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(
                    height: 300,
                    'https://firebasestorage.googleapis.com/v0/b/watch-hub-6810e.appspot.com/o/not-found-removebg-preview.png?alt=media&token=c98edcd3-07e1-4016-b510-a34bdd687fae'),
                const Text(
                  "No Orders Made",
                  style: TextStyle(fontSize: 30.0),
                )
              ],
            ))
          : ListView.builder(
              itemCount: order.length,
              itemBuilder: (
                context,
                index,
              ) {
                int totalQuantity =
                    order[index].price! * order[index].quantity!;
                return Column(
                  children: [
                    Container(
                        // height: 50,
                        child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          order[index].image!,
                        ),
                      ),
                      title: Text(
                        "${order[index].model!}(${order[index].quantity})",
                        style: const TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(
                        order[index].brand!,
                        style: const TextStyle(fontSize: 20),
                      ),
                      trailing: Text(
                        totalQuantity.toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                    )),
                    Divider()
                  ],
                );
              },
            ),
    );
  }
}
