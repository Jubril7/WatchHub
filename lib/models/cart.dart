import 'package:flutter/material.dart';

class Cart extends ChangeNotifier {
  final String? brand;
  final String? model;
  final int? price;
  final String? image;
  int? quantity;

  Cart({
    this.brand,
    this.model,
    this.price,
    this.image,
    this.quantity,
  });
}
