import 'package:flutter/material.dart';

class Watch extends ChangeNotifier {
  final String? id;
  final String? brand;
  final String? model;
  final String? type;
  final int? popularity;
  final String? price;
  final String? image;
  final String? description;
  final String? resistance;
  final String? material;
  final String? color;
  final String? descImg1;
  final String? descImg2;
  final String? descImg3;
  final List? images;
  final List<dynamic>? reviews;

  Watch({
    this.id,
    this.brand,
    this.model,
    this.type,
    this.popularity,
    this.price,
    this.image,
    this.description,
    this.resistance,
    this.material,
    this.color,
    this.descImg1,
    this.descImg2,
    this.descImg3,
    this.images,
    this.reviews,
  });
}
