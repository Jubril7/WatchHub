import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_hub/models/watch.dart';
import 'package:watch_hub/models/cart.dart';
import 'package:watch_hub/services/database.dart';

class CartList extends StatefulWidget {
  const CartList({super.key});

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  int? counter;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<List<Cart>>(context);
    // cart.sort();

    cart.forEach((cart) {
      print("cart model is ${cart.brand}");
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (
          context,
          index,
        ) {
          int? initialQuantity = cart[index].quantity;
          counter = cart[index].quantity;
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
                          style:
                              IconButton.styleFrom(backgroundColor: Colors.red),
                          onPressed: () {
                            setState(() {
                              cart[index].quantity! > 1
                                  ? cart[index].quantity =
                                      cart[index].quantity! - 1
                                  : cart[index].quantity =
                                      cart[index].quantity!;

                              DatabaseService().increaseCartQuantity(
                                  cart[index].model!,
                                  cart[index].brand!,
                                  cart[index].image!,
                                  cart[index].price!,
                                  initialQuantity,
                                  cart[index].quantity!);
                            });
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
                              "QTY: ${cart[index].quantity.toString()}",
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                        IconButton.filled(
                          style: IconButton.styleFrom(
                              backgroundColor: Colors.green),
                          onPressed: () {
                            setState(() {
                              cart[index].quantity = cart[index].quantity! + 1;
                              print("counter plus is ${initialQuantity}");
                              DatabaseService().increaseCartQuantity(
                                  cart[index].model!,
                                  cart[index].brand!,
                                  cart[index].image!,
                                  cart[index].price!,
                                  initialQuantity,
                                  cart[index].quantity!);
                              // print(
                              //     "new quantity is ${newQuantity!++}");
                            });
                          },
                          icon: Icon(Icons.add),
                        ),
                      ],
                    )),
              ),
            ],
          );
        },
      ),
    );
  }
}
