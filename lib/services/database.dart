import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter/material.dart';
import 'package:watch_hub/models/cart.dart';
import "package:watch_hub/models/watch.dart";
import 'package:watch_hub/screens/home/home.dart';
import 'package:watch_hub/screens/home/shop/watch_detail.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService extends ChangeNotifier {
  final String? uid;
  final FirebaseFirestore? db;
  DatabaseService({this.uid, this.db});

  final FirebaseAuth auth = FirebaseAuth.instance;

  //collection reference
  final CollectionReference users =
      FirebaseFirestore.instance.collection("Users");

  final CollectionReference watch_list =
      FirebaseFirestore.instance.collection("watch_hub");

  final DocumentReference<Map<String, dynamic>> cart =
      FirebaseFirestore.instance.collection("Cart").doc(user!.uid);
  final DocumentReference<Map<String, dynamic>> order =
      FirebaseFirestore.instance.collection("Orders").doc(user!.uid);
  final DocumentReference<Map<String, dynamic>> favourite =
      FirebaseFirestore.instance.collection("Favourites").doc(user!.uid);

  int totalPrice = 0;
  String totalPriceString = '';
  Future<int> updateTotalPrice() async {
    // another example of getting the data
    DocumentSnapshot<Map<String, dynamic>> document = await FirebaseFirestore
        .instance
        .collection("Cart")
        .doc(user!.uid)
        .get();

    List item = document.data()!['cart'];
    print("item list is ${item}");
    List totalPriceList = [];

    for (var i in item) {
      totalPriceList.add(i['price'] * i['quantity']);
    }
    return totalPriceList.reduce((value, element) => value + element);
  }

  void updateQuantity(int index, int quantity, String model) async {
    DocumentSnapshot<Map<String, dynamic>> cartList = await FirebaseFirestore
        .instance
        .collection("Cart")
        .doc(user!.uid)
        .get();
    List item = cartList.data()!['cart'];

    List quantityList = item;

    var getIndex = quantityList.firstWhere((item) => item['model'] == model);
    if (getIndex != null) {
      getIndex['quantity'] += quantity;
      cart.set({"cart": FieldValue.arrayUnion(item)});
    }

    updateTotalPrice();
    notifyListeners();
  }

  Future setUserData(
      String email, String address, String fullName, String phone) async {
    return await users.doc(uid).set({
      "email": email,
      "address": address,
      "fullname": fullName,
      "phone": phone,
    });
  }

  Future createOrder() async {
    User? user = auth.currentUser;
    DocumentSnapshot<Map<String, dynamic>> getCart = await FirebaseFirestore
        .instance
        .collection("Cart")
        .doc(user!.uid)
        .get();
    DocumentReference<Map<String, dynamic>> document =
        await FirebaseFirestore.instance.collection("Orders").doc(user.uid);
    List docs = [];
    List docs1 = [];
    docs.add(getCart.data()!);
    docs1 = docs[0]['cart'];
    print("docs1 says $docs1");
    document
        .set({"cart": FieldValue.arrayUnion(docs1)}, SetOptions(merge: true));

    cart.update({"cart": FieldValue.delete()});
    notifyListeners();
  }

  Future addToCart(
    String model,
    String brand,
    int quantity,
    int price,
    String image,
  ) async {
    try {
      User? user = auth.currentUser;
      DocumentSnapshot<Map<String, dynamic>> document = await FirebaseFirestore
          .instance
          .collection("Cart")
          .doc(user!.uid)
          .get();
      DocumentReference docRef =
          FirebaseFirestore.instance.collection("Cart").doc(user.uid);
      updateTotalPrice();
      notifyListeners();
      await cart.set({
        "cart": FieldValue.arrayUnion([
          {
            "brand": brand,
            "model": model,
            "quantity": quantity,
            "price": price,
            "image": image,
          }
        ])
      }, SetOptions(merge: true));
    } catch (e) {
      print(e.toString());
    }
  }

  Future deleteFromCart(
    String model,
    String brand,
    int quantity,
    int price,
    String image,
  ) async {
    try {
      User? user = auth.currentUser;
      DocumentSnapshot<Map<String, dynamic>> document = await FirebaseFirestore
          .instance
          .collection("Cart")
          .doc(user!.uid)
          .get();
      DocumentReference docRef =
          FirebaseFirestore.instance.collection("Cart").doc(user.uid);

      await cart.set({
        "cart": FieldValue.arrayRemove([
          {
            "brand": brand,
            "model": model,
            "quantity": quantity,
            "price": price,
            "image": image,
          }
        ])
      }, SetOptions(merge: true));
    } catch (e) {
      print(e.toString());
    }
    updateTotalPrice();
  }

  Future addToFavourites(
    String model,
    String brand,
    int quantity,
    int price,
    String image,
  ) async {
    try {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection("Favourites").doc(user!.uid);
      updateTotalPrice();
      notifyListeners();
      await favourite.set({
        "cart": FieldValue.arrayUnion([
          {
            "brand": brand,
            "model": model,
            "quantity": quantity,
            "price": price,
            "image": image,
          }
        ])
      }, SetOptions(merge: true));
    } catch (e) {
      print(e.toString());
    }
  }

  Future removeFromFavourites(
    String model,
    String brand,
    int quantity,
    int price,
    String image,
  ) async {
    try {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection("Favourites").doc(user!.uid);
      updateTotalPrice();
      notifyListeners();
      await favourite.set({
        "cart": FieldValue.arrayRemove([
          {
            "brand": brand,
            "model": model,
            "quantity": quantity,
            "price": price,
            "image": image,
          }
        ])
      }, SetOptions(merge: true));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> getFavouriteBool(String model) async {
    print("function ran");
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot<Map<String, dynamic>> document = await FirebaseFirestore
        .instance
        .collection("Favourites")
        .doc(user!.uid)
        .get();

    List item = document.data()!['cart'];
    print("item list is ${item}");
    for (var i = 0; i < item.length; i++) {
      List modelList = [];
      modelList.add(item[i]['model']);
      print("model says before condition ${item[i]['model']}");

      if (modelList.contains(model)) {
        return true;
      }
    }
    return false;
  }

  void editProfile(String fullname, String phone, String address) {
    users.doc(user!.uid).update({
      "fullname": fullname,
      "phone": phone,
      "address": address,
      "email": user!.email,
    });
  }

  Future<bool> getCartBool(String model) async {
    print("function ran");
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot<Map<String, dynamic>> document = await FirebaseFirestore
        .instance
        .collection("Cart")
        .doc(user!.uid)
        .get();

    List item = document.data()!['cart'];
    print("item list is ${item}");
    for (var i = 0; i < item.length; i++) {
      List modelList = [];
      modelList.add(item[i]['model']);
      print("model says before condition ${item[i]['model']}");

      if (modelList.contains(model)) {
        return true;
      }
    }
    return false;
  }

  // cart list from snapshot
  List<Cart> _cartFromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    List docs = [];
    List docs1 = [];
    docs.add(snapshot.data()!);
    docs1 = docs[0]['cart'];
    print("docs1 says $docs1");
    updateTotalPrice();

    return docs1.map((doc) {
      print("cart brand is ${doc['brand']}");

      return Cart(
        brand: doc['brand'] ?? '',
        model: doc['model'] ?? '',
        price: doc['price'] ?? 0,
        image: doc['image'] ?? '',
        quantity: doc['quantity'] ?? 0,
      );
    }).toList();
  }

  //watch list from snapshot
  Future addUserReview(
      double userStarRating, String userReview, String docId) async {
    final now = DateTime.now();
    DateTime dateOptions = DateTime(now.year, now.month, now.day);
    final date = dateOptions.toString().replaceAll("00:00:00.000", "");
    print("date is $date");
    User? user = auth.currentUser;
    DocumentSnapshot<Map<String, dynamic>> userName = await FirebaseFirestore
        .instance
        .collection("Users")
        .doc(user!.uid)
        .get();

    DocumentReference watch_item =
        await FirebaseFirestore.instance.collection("watch_hub").doc(docId);

    watch_item.update({
      "reviews": FieldValue.arrayUnion([
        {
          "name": userName.data()!['fullname'],
          "review": userReview,
          "stars": userStarRating,
          "time": date.toString().replaceAll(" ", ""),
        }
      ])
    });
  }

  List<Watch> _watchListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Watch(
          id: doc['id'] ?? '',
          brand: doc['brand'] ?? '',
          model: doc['model'] ?? '',
          type: doc['type'] ?? '',
          popularity: doc['popularity'] ?? 0,
          price: doc['price'].toString(),
          image: doc['image'] ?? '',
          description: doc['description'] ?? '',
          resistance: doc['resistance'] ?? '',
          material: doc['material'] ?? '',
          color: doc['color'] ?? '',
          descImg1: doc['desc_img1'] ?? '',
          descImg2: doc['desc_img2'] ?? '',
          descImg3: doc['desc_img3'] ?? '',
          images: doc['images'] ?? [],
          reviews: doc['reviews'] ?? []);
    }).toList();
  }

  //get watches list

  Stream<List<Watch>> get watches {
    dynamic brand = OptionsClass.currentBrand;
    dynamic type = OptionsClass.currentType;
    late Query filter;

    brand is int && type is int
        ? filter = watch_list
        : filter = watch_list.where(Filter.and(
            brand is String
                ? Filter("brand", isEqualTo: brand)
                : Filter("brand", isNotEqualTo: ['']),
            type is String
                ? Filter("type", isEqualTo: type)
                : Filter("type", isNotEqualTo: [''])));

    return filter.snapshots().map(_watchListFromSnapshot);
  }

  Stream<List<Cart>> get carts {
    return cart.snapshots().map(_cartFromSnapshot);
  }

  Stream<List<Cart>> get orders {
    return order.snapshots().map(_cartFromSnapshot);
  }

  Stream<List<Cart>> get favourites {
    return favourite.snapshots().map(_cartFromSnapshot);
  }
}
