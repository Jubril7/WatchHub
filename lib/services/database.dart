import "package:cloud_firestore/cloud_firestore.dart";
import 'package:watch_hub/models/cart.dart';
import "package:watch_hub/models/watch.dart";
import 'package:watch_hub/screens/home/home.dart';
import 'package:watch_hub/screens/home/watch_detail.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetBool {
  static Future<bool>? isAdded;
}

class DatabaseService {
  final String? uid;
  final FirebaseFirestore? db;
  DatabaseService({this.uid, this.db});

  final FirebaseAuth auth = FirebaseAuth.instance;

  //collection reference
  final CollectionReference users =
      FirebaseFirestore.instance.collection("Users");

  final CollectionReference watch_list =
      FirebaseFirestore.instance.collection("watch_hub");

  final CollectionReference cart =
      FirebaseFirestore.instance.collection("Cart");

  // dynamic brand = "Longines";
  // dynamic model = "Aviation Big Eye";

  // watch_list.where(Filter.and(Filter("brand", isEqualTo: "Longines"),
  //     Filter("id", isEqualTo: true), Filter("type", isEqualTo: "Analog")));

  Future setUserData(
      String email, String address, String fullName, String phone) async {
    return await users.doc(uid).set({
      "email": email,
      "address": address,
      "fullName": fullName,
      "phone": phone,
    });
  }

  Future addToCart(
    String model,
    String brand,
    int quantity,
    int price,
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

      // await cart.doc(user!.uid).set({
      //   "cart": FieldValue.arrayUnion([
      //     {
      //       "brand": brand,
      //       "model": model,
      //       "quantity": quantity,
      //       "price": price,
      //     }
      //   ])
      // }, SetOptions(merge: true));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> getBool(String model) async {
    print("function ran");
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot<Map<String, dynamic>> document = await FirebaseFirestore
        .instance
        .collection("Cart")
        .doc(user!.uid)
        .get();

    DocumentReference docRef =
        FirebaseFirestore.instance.collection("Cart").doc(user.uid);
    List list = [];
    for (var doc in document.data()!['cart'] as Iterable) {
      list.add(doc['model']);
      print("model says before condition $model");
      print("list is $list");

      if (list.contains(model)) {
        // GetBool.isAdded = true;
        print("this item  exist");

        return true;
      } else {
        GetBool.isAdded!.then((item) => item = false);

        print("this item doesnt exist");
        return true;
      }
    }
    return false;
  }

  //cart list from snapshot
  // List<Cart> _cartFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     return Cart(
  //       brand: doc['brand'] ?? '',
  //       model: doc['model'] ?? '',
  //       price: doc['price'] ?? '',
  //       image: doc['image'] ?? '',
  //       quantity: doc['quantity'] ?? '',
  //     );
  //   }).toList();
  // }

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
          "name": userName.data()!['fullName'],
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
  get sth async {
    print("this ran");
  }

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

//   Stream<List<Cart>> get carts {
//     return cart.snapshots().map(_cartFromSnapshot);
//   }
// }
}
