import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:provider/provider.dart';
import 'package:watch_hub/models/cart.dart';
import 'package:watch_hub/models/watch.dart';
import 'package:watch_hub/screens/home/watch_tile.dart';
import 'package:watch_hub/services/database.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
User? user = auth.currentUser;

class WatchDetail extends StatefulWidget {
  const WatchDetail({super.key});

  @override
  State<WatchDetail> createState() => _WatchDetailState();
}

class _WatchDetailState extends State<WatchDetail> {
  bool? waefaw;
  final DatabaseService _database = DatabaseService();

  @override
  void initState() {
    super.initState();
    asyncMethod();
  }

  void asyncMethod() async {
    waefaw = await DatabaseService().getBool('Aviation Big Eye');
  }

  int itemQuantity = 1;
  @override
  Widget build(BuildContext context) {
    final watch = ModalRoute.of(context)?.settings.arguments as Watch;
    // final cart = Provider.of<List<Cart>>(context);

    print("route args is ${watch.brand}");
    bool? result;

    print("getbool says ${waefaw}");
    print("desc says ${watch.description}");
    for (var image in watch.images!) {
      print("image says $image");
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(watch.brand!),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: CarouselSlider(
                items: watch.images!.map((item) {
                  return FullScreenWidget(
                    disposeLevel: DisposeLevel.Medium,
                    child: Center(
                      child: Container(
                        height: 300,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(item), fit: BoxFit.cover)),
                      ),
                    ),
                  );
                }).toList(),
                options: CarouselOptions(height: 300),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
              child: Container(
                width: double.maxFinite,
                child: Text(watch.brand!,
                    style: TextStyle(fontSize: 18.0, color: Colors.grey[700])),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
              child: Container(
                width: double.maxFinite,
                child: Text(
                  watch.model!,
                  style: TextStyle(fontSize: 23.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 5.0, 0.0, 0.0),
              child: Container(
                width: double.maxFinite,
                child: Text(
                  "\$${watch.price!}",
                  style: TextStyle(fontSize: 23.0),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(
                    "Quantity: ",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                    ),
                    onPressed: () {
                      setState(() {
                        if (itemQuantity < 2) {
                          itemQuantity = 1;
                        } else {
                          itemQuantity--;
                        }
                      });
                    },
                    child: const Text(
                      "-",
                      style: TextStyle(fontSize: 25.0, color: Colors.black),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    itemQuantity.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero)),
                    onPressed: () {
                      setState(() {
                        itemQuantity++;
                      });
                    },
                    child: const Text(
                      "+",
                      style: TextStyle(fontSize: 25.0, color: Colors.black),
                    ))
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: waefaw == false
                      ? ElevatedButton(
                          onPressed: () async {
                            await _database.addToCart(
                                watch.model!,
                                watch.brand!,
                                itemQuantity,
                                int.parse(watch.price!));
                          },
                          child: const Text("Add To Cart"),
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero)),
                          onPressed: () {},
                          child: const Row(
                            children: [
                              Text(
                                "Added To Cart",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              ),
                            ],
                          )),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
                width: double.maxFinite,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Description",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                )),
            Container(
              color: Colors.grey[300],
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      watch.description!,
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
                width: double.maxFinite,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Specifications",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                )),
            Container(
              width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: double.maxFinite,
                      child: Text(
                        "Model - ${watch.model!}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: Text(
                        "Type - ${watch.type!}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: Text(
                        "Water Resistance - ${watch.resistance!}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: Text(
                        "Material - ${watch.material!}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: Text(
                        "Color - ${watch.color!}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
