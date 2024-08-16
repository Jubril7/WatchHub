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
    final carts = Provider.of<DatabaseService>(context);

    double maxWidth = MediaQuery.sizeOf(context).width;

    List totalPriceList = [];
    int totalQuantity;
    // cart.sort();

    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Consumer<List<Cart>>(builder: (context, cart, child) {
        return ListView.builder(
          itemCount: cart.length,
          itemBuilder: (
            context,
            index,
          ) {
            int price = 0;
            GetPrice.quantity = cart[index].quantity!;
            int? initialQuantity = cart[index].quantity;
            GetPrice.quantity = cart[index].quantity!;
            int counter = cart[index].price! * cart[index].quantity!;

            // GetPrice.price = 5522;
            totalPriceList.add(counter);
            // totalPriceList.reduce((value, element) {
            //   GetPrice.price = value + element;
            //   print("reduce value $value");
            //   print("reduce element $element");
            // });
            cart.map((item) => print("price list is ${item.brand}"));

            print("quantity list is ${GetPrice.quantity}");
            print("total is ${GetPrice.price.toString()}");

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
                                var cont = context.read<DatabaseService>();
                                cart[index].quantity =
                                    cart[index].quantity! - 1;

                                cont.increaseQuantity();
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
                              var cont = context.read<DatabaseService>();
                              cart[index].quantity = cart[index].quantity! + 1;
                              print("increase price is ${GetPrice.price}");
                              cont.increaseQuantity();

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
                    },
                    child: Text("Make Order"),
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
