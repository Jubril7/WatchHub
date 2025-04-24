import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:watch_hub/models/watch.dart';
import 'package:watch_hub/screens/home/home.dart';
import 'package:watch_hub/services/database.dart';

class ReviewSort {
  static List<dynamic> sortOptions = [0, 'oldest'];
  static dynamic currentSort = sortOptions[0];
}

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

  final _formKey = GlobalKey<FormState>();
  String error = '';
  num? userStarRating;
  String? userReview;
  int itemQuantity = 1;
  @override
  Widget build(BuildContext context) {
    final watch = ModalRoute.of(context)?.settings.arguments as Watch;
    final now = DateTime.now();

    DateTime dateOptions = DateTime(now.year, now.month, now.day);
    final date = dateOptions.toString().replaceAll("00:00:00.000", "");
    print("watch is $watch");
    ;
    // final cart = Provider.of<List<Cart>>(context);
    List? watchSort = watch.reviews;
    ("current is from beginning");
    ReviewSort.currentSort == 0
        ? watchSort!.sort((a, b) {
            String firstSort = a['time'];
            String secondSort = b['time'];
            print("hello");

            return firstSort.compareTo(secondSort);
          })
        : watchSort!.sort((a, b) {
            String firstSort = a['time'];
            String secondSort = b['time'];

            return secondSort.compareTo(firstSort);
          });

    print("watch sort $watchSort");

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 253, 249, 246),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text(
          "Watch Detail",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 22, 69, 169),
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
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
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
                      backgroundColor: Color.fromARGB(255, 253, 249, 246),
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
                        backgroundColor:
                            const Color.fromARGB(255, 253, 249, 246),
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
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 8, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Stock: Available",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder(
                    future: DatabaseService().getCartBool(watch.model!),
                    builder: (context, snapshot) {
                      print("snapshot data bool is ${snapshot.data}");
                      return Container(
                          width: 240,
                          child: snapshot.data == true
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton.icon(
                                    icon: const Icon(
                                      Icons.shopping_cart,
                                      color: Color.fromARGB(255, 139, 185, 255),
                                    ),
                                    label: const Text(
                                      "Added To Cart",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 139, 185, 255),
                                          fontSize: 20),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            232, 255, 255, 255),
                                        side: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 139, 185, 255),
                                        ),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.zero)),
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/cart');
                                    },
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton.icon(
                                    icon: const Icon(
                                      Icons.shopping_cart,
                                      color: Colors.white,
                                    ),
                                    label: const Text(
                                      "Add To Cart",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Color.fromARGB(255, 139, 185, 255),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.zero)),
                                    onPressed: () async {
                                      await _database.addToCart(
                                        watch.model!,
                                        watch.brand!,
                                        itemQuantity,
                                        int.parse(watch.price!),
                                        watch.images![0],
                                      );
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
                                    },
                                  ),
                                ));
                    }),
                FutureBuilder(
                  future: DatabaseService().getFavouriteBool(watch.model!),
                  builder: (context, snapshot) => snapshot.data == true
                      ? IconButton(
                          onPressed: () {
                            DatabaseService().removeFromFavourites(
                                watch.model!,
                                watch.brand!,
                                1,
                                int.parse(watch.price!),
                                watch.images![0]);
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text("Watch Hub"),
                                      content:
                                          const Text("Removed From Wishlist"),
                                      contentPadding: EdgeInsets.all(20.0),
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              Navigator.of(context).pop();
                                            },
                                            child: (const Text("Close")))
                                      ],
                                    ));
                          },
                          icon: const Icon(
                            Icons.favorite,
                            size: 40,
                            color: Colors.pink,
                          ))
                      : IconButton(
                          onPressed: () {
                            DatabaseService().addToFavourites(
                                watch.model!,
                                watch.brand!,
                                1,
                                int.parse(watch.price!),
                                watch.images![0]);
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text("Watch Hub"),
                                      content: const Text("Added To Wishlist"),
                                      contentPadding: EdgeInsets.all(20.0),
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              Navigator.of(context).pop();
                                            },
                                            child: (const Text("Close")))
                                      ],
                                    ));
                          },
                          icon: const Icon(
                            Icons.favorite,
                            size: 40,
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
            DropdownMenu(
              width: 200,
              label: Text("Date"),
              dropdownMenuEntries: <DropdownMenuEntry>[
                DropdownMenuEntry(
                    value: ReviewSort.sortOptions[1], label: 'Sort By Newest'),
                DropdownMenuEntry(
                    value: ReviewSort.sortOptions[0], label: 'Sort By Oldest'),
              ],
              onSelected: (value) => {
                setState(() {
                  ReviewSort.currentSort = value;
                  // print("current is $currentSort");
                })
              },
            ),
            SizedBox(
              width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: watchSort.length,
                  itemBuilder: (context, int index) {
                    // reviewSort.sort((a, b) {
                    //   String af = a;
                    //   String bf = b;
                    //   return af.compareTo(bf);
                    // });
                    num rating;
                    watchSort[index]['stars'] == null
                        ? rating = 0.0
                        : rating = watchSort[index]['stars'];

                    return ListTile(
                      leading: RatingBar.builder(
                        allowHalfRating: true,
                        ignoreGestures: true,
                        itemSize: 19,
                        initialRating: rating.toDouble(),
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (value) => print(value),
                      ),
                      // Text(
                      //   watch.reviews![index]['name'],
                      //   style: const TextStyle(fontSize: 20),
                      // ),
                      title: Text(
                        watchSort[index]['review'],
                        style: const TextStyle(fontSize: 20),
                      ),

                      subtitle: Text(watchSort[index]['name']),
                      trailing: Text(
                        watchSort[index]['time'],
                        style: const TextStyle(fontSize: 17),
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
                  SizedBox(
                    width: double.maxFinite,
                    child: RatingBar.builder(
                        allowHalfRating: true,
                        itemSize: 30,
                        itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                        onRatingUpdate: (value) => setState(() {
                              userStarRating = value;
                            })),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 400,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 139, 185, 255)),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await DatabaseService().addUserReview(
                                userStarRating!.toDouble(),
                                userReview!,
                                watch.id!);
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text("Watch Hub"),
                                      content: const Text("Review Sent"),
                                      contentPadding: EdgeInsets.all(20.0),
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              Navigator.of(context).pop();
                                            },
                                            child: (const Text("Close")))
                                      ],
                                    ));

                            setState(() {
                              watchSort.add({
                                "name": UserInformation.fullName,
                                "review": userReview,
                                "stars": userStarRating!.toDouble(),
                                "time": date
                              });
                            });
                          }
                        },
                        child: const Text(
                          "Send Review",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
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
