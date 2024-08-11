import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:watch_hub/models/watch.dart';
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

  final _formKey = GlobalKey<FormState>();
  String error = '';
  double? userStarRating;
  String? userReview;
  int itemQuantity = 1;
  @override
  Widget build(BuildContext context) {
    final watch = ModalRoute.of(context)?.settings.arguments as Watch;

    // final cart = Provider.of<List<Cart>>(context);

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
                options: CarouselOptions(
                    height: 300,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    autoPlay: true),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
              child: SizedBox(
                width: double.maxFinite,
                child: Text(watch.brand!,
                    style: TextStyle(fontSize: 18.0, color: Colors.grey[700])),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
              child: SizedBox(
                width: double.maxFinite,
                child: Text(
                  watch.model!,
                  style: const TextStyle(fontSize: 23.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 5.0, 0.0, 0.0),
              child: SizedBox(
                width: double.maxFinite,
                child: Text(
                  "\$${watch.price!}",
                  style: const TextStyle(
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 181, 61, 53)),
                ),
              ),
            ),
            const SizedBox(
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
            const SizedBox(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.black),
                          bottom: BorderSide(color: Colors.black))),
                  width: double.maxFinite,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Description",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
            Container(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.black),
                          bottom: BorderSide(color: Colors.black))),
                  width: double.maxFinite,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Specifications",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
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
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.black),
                          bottom: BorderSide(color: Colors.black))),
                  width: double.maxFinite,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Reviews",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
            SizedBox(
              width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: watch.reviews!.length,
                  itemBuilder: (context, int index) {
                    double rating = watch.reviews![index]['stars'];

                    return ListTile(
                      leading: Text(
                        watch.reviews![index]['name'],
                        style: const TextStyle(fontSize: 20),
                      ),
                      title: Column(
                        children: [
                          Text(
                            watch.reviews![index]['review'],
                            style: const TextStyle(fontSize: 20),
                          ),
                          RatingBar(
                            ignoreGestures: true,
                            itemSize: 19,
                            initialRating: rating,
                            ratingWidget: RatingWidget(
                                empty: const Icon(
                                  Icons.star,
                                ),
                                half: const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                full: const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                )),
                            onRatingUpdate: (value) => print(value),
                          )
                        ],
                      ),
                      trailing: Text(
                        watch.reviews![index]['time'],
                        style: TextStyle(fontSize: 17),
                      ),
                    );
                  },
                  separatorBuilder: (context, int index) => const Divider(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Card(
                      color: Color.fromARGB(255, 226, 226, 226),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (val) => val!.isEmpty
                              ? 'Please Enter A Review Before Sending'
                              : null,
                          onChanged: (value) {
                            setState(() {
                              userReview = value;
                            });
                          },
                          maxLines: 8, //or null
                          decoration: const InputDecoration(
                              hintText: "Write A Review",
                              errorStyle: TextStyle(fontSize: 17),
                              border: InputBorder.none),
                        ),
                      )),
                  Container(
                    width: double.maxFinite,
                    child: RatingBar(
                        itemSize: 30,
                        ratingWidget: RatingWidget(
                            empty: const Icon(
                              Icons.star,
                            ),
                            half: const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            full: const Icon(
                              Icons.star,
                              color: Colors.amber,
                            )),
                        onRatingUpdate: (value) => setState(() {
                              userStarRating = value;
                            })),
                  ),
                  Container(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() async {
                            await DatabaseService().addUserReview(
                                userStarRating!, userReview!, watch.id!);
                          });
                        }
                      },
                      child: Text("Send Review"),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
