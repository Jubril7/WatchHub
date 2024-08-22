import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_hub/models/cart.dart';
import 'package:watch_hub/services/database.dart';

class CartList extends StatefulWidget {
  const CartList({super.key});

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  @override
  Widget build(BuildContext context) {
    final carts = Provider.of<DatabaseService>(context);

    double maxWidth = MediaQuery.sizeOf(context).width;

    List totalPriceList = [];
    int totalQuantity;
    String total = '';
    // cart.sort();

    return StreamBuilder<List<Cart>>(
        stream: DatabaseService().carts,
        builder: (context, snapshot) {
          var cart = snapshot.data;
          print("provider answer is${total}");
          return Scaffold(
            backgroundColor: const Color.fromARGB(232, 255, 255, 255),
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 22, 69, 169),
              iconTheme: const IconThemeData(
                color: Colors.white, //change your color here
              ),
              title: const Text(
                "",
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: !snapshot.hasData
                ?
                //  cart = data.sort(());
                Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.network(
                            height: 300,
                            'https://firebasestorage.googleapis.com/v0/b/watch-hub-6810e.appspot.com/o/not-found-removebg-preview.png?alt=media&token=c98edcd3-07e1-4016-b510-a34bdd687fae'),
                        const Text(
                          "Cart Is Empty",
                          style: TextStyle(fontSize: 30.0),
                        )
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: cart!.length,
                    itemBuilder: (
                      context,
                      index,
                    ) {
                      return Column(
                        children: [
                          Container(
                            // height: 50,
                            child: ListTile(
                                dense: true,
                                visualDensity: const VisualDensity(vertical: 4),
                                leading: SizedBox(
                                    child: Image.network(cart[index].image!)),
                                title: Text(
                                  cart[index].model!,
                                  style: TextStyle(fontSize: 20),
                                ),
                                subtitle: Row(
                                  children: [
                                    Text(
                                      "\$${cart[index].price.toString()!}",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        DatabaseService().deleteFromCart(
                                            cart[index].model!,
                                            cart[index].brand!,
                                            cart[index].quantity!,
                                            cart[index].price!,
                                            cart[index].image!);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      iconSize: 30,
                                    )
                                  ],
                                ),
                                trailing: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border:
                                          Border.all(color: Colors.lightBlue)),
                                  height: 120,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          if (cart[index].quantity != 1) {
                                            Provider.of<DatabaseService>(
                                                    context,
                                                    listen: false)
                                                .updateQuantity(index, -1,
                                                    cart[index].model!);
                                          }
                                        },
                                        icon: Icon(Icons.remove),
                                      ),

                                      Text(
                                        cart[index].quantity.toString(),
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      //

                                      IconButton(
                                        onPressed: () {
                                          Provider.of<DatabaseService>(context,
                                                  listen: false)
                                              .updateQuantity(
                                                  index, 1, cart[index].model!);
                                        },
                                        icon: Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      );
                    },
                  ),
            bottomSheet: Container(
                height: 130,
                width: MediaQuery.sizeOf(context).width,
                color: Color.fromARGB(255, 22, 69, 169),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            //  Provider.of<DatabaseService>(context).
                            //
                            'Total',
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: FutureBuilder(
                              future: Provider.of<DatabaseService>(context)
                                  .updateTotalPrice(),
                              builder: (context, data) {
                                return Text(
                                  '\$${data.data.toString()}',
                                  style: const TextStyle(
                                      fontSize: 25, color: Colors.white),
                                );
                              }),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 200,
                          child: FloatingActionButton(
                            backgroundColor: Color.fromARGB(255, 139, 185, 255),
                            onPressed: () {
                              DatabaseService().createOrder();
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: const Text("Watch Hub"),
                                        content: const Text("Order Confirmed"),
                                        contentPadding: EdgeInsets.all(20.0),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: (const Text("Close")))
                                        ],
                                      ));
                              // Navigator.pushNamed(
                              //   context,
                              //   "/orders",
                              // );
                            },
                            child: const Text(
                              "Confirm Order",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )),
          );
        });
  }
}
