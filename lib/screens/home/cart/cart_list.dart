import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_hub/models/cart.dart';
import 'package:watch_hub/services/database.dart';

class GetPrice {
  static num? price = 0;
  static int quantity = 0;
  static List carts = [];
}

class CartList extends StatefulWidget {
  const CartList({super.key});

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  static int? price;

  @override
  Widget build(BuildContext context) {
    final carts = Provider.of<DatabaseService>(context, listen: true);

    double maxWidth = MediaQuery.sizeOf(context).width;

    List totalPriceList = [];
    int totalQuantity;
    // cart.sort();

    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Consumer<List<Cart>>(builder: (context, cart, child) {
        if (cart.isEmpty) {
          return Center(
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
          );
        } else {
          return ListView.builder(
            itemCount: cart.length,
            itemBuilder: (
              context,
              index,
            ) {
              int price = 0;
              GetPrice.quantity = cart[index].quantity!;
              int? initialQuantity = cart[index].quantity;

              int counter = cart[index].price! * cart[index].quantity!;

              totalPriceList.add(counter);

              cart.map((item) => print("price list is ${item.brand}"));

              print("quantity list is ${GetPrice.quantity}");
              print("total is ${GetPrice.price}");

              return Column(
                children: [
                  Container(
                    // height: 50,
                    child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            cart[index].image!,
                          ),
                        ),
                        title: Text(
                          cart[index].model!,
                          style: TextStyle(fontSize: 20),
                        ),
                        subtitle: Text(
                          cart[index].brand!,
                          style: TextStyle(fontSize: 20),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton.filled(
                              style: IconButton.styleFrom(
                                  backgroundColor: Colors.red),
                              onPressed: () {
                                if (cart[index].quantity != 1) {
                                  // var increment = context.read<DatabaseService>();
                                  // increment
                                  //     .decreaseQuantity(cart[index].quantity!);
                                  // var cont = context.read<DatabaseService>();
                                  cart[index].quantity =
                                      cart[index].quantity! - 1;
                                  carts.updateQuantity();

                                  // cont.increaseQuantity();
                                  // setState(() {
                                  //   // DatabaseService().decreaseQuantity();

                                  //   print("price list is $totalPriceList");

                                  //   DatabaseService().updateCartQuantity(
                                  //       cart[index].model!,
                                  //       cart[index].brand!,
                                  //       cart[index].image!,
                                  //       cart[index].price!,
                                  //       initialQuantity!,
                                  //       cart[index].quantity!);

                                  //   print("price list is $totalPriceList");
                                  // });
                                }
                              },
                              icon: Icon(Icons.remove),
                            ),
                            Column(
                              children: [
                                Text(
                                  cart[index].price.toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  "QTY: ${GetPrice.quantity.toString()}",
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            IconButton.filled(
                              style: IconButton.styleFrom(
                                  backgroundColor: Colors.green),
                              onPressed: () {
                                // var increment = context.read<DatabaseService>();
                                // increment.increaseQuantity(cart[index].quantity!);

                                cart[index].quantity =
                                    cart[index].quantity! + 1;
                                carts.updateQuantity();
                                print("increase price is ${GetPrice.price}");
                                GetPrice.price =
                                    totalPriceList.reduce((value, element) {
                                  print("reduce value $value");
                                  print("reduce element $element");
                                  value + element;
                                });

                                // setState(() {
                                //   // cart[index].quantity =
                                //   //     cart[index].quantity! + 1;

                                //   print("counter plus is ${initialQuantity}");
                                //   print("getprice price ${GetPrice.price}");
                                //   // print("price list is $totalPriceList");
                                //   // DatabaseService().updateCartQuantity(
                                //   //     cart[index].model!,
                                //   //     cart[index].brand!,
                                //   //     cart[index].image!,
                                //   //     cart[index].price!,
                                //   //     initialQuantity!,
                                //   //     cart[index].quantity!);
                                // });
                                // print("total is $price");
                              },
                              icon: Icon(Icons.add),
                            ),
                          ],
                        )),
                  ),
                ],
              );
            },
          );
        }
      }),
      bottomSheet: Container(
        height: 130,
        color: Colors.brown[400],
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Total ",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "\$${GetPrice.price.toString()}",
                    style: const TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: FloatingActionButton(
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
                    child: Text("Confirm Order"),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
