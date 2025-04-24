import 'package:flutter/material.dart';

class Watch extends ChangeNotifier {
  final String? id;
  final String? brand;
  final String? model;
  final String? type;
  final int? popularity;
  final String? price;
  final String? imageUrl;
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
    this.imageUrl,
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

  factory Watch.fromFirestore(Map<String, dynamic> data, String id) {
  return Watch(
    id: id,
    brand: data['brand'],
    model: data['model'],
    type: data['type'],
    popularity: data['popularity'],
    price: data['price'],
    imageUrl: data['imageUrl'],
    description: data['description'],
    resistance: data.containsKey('resistance') ? data['resistance'] : null,
    material: data['material'],
    color: data['color'],
    descImg1: data['descImg1'],
    descImg2: data['descImg2'],
    descImg3: data['descImg3'],
    images: data['images'] is List ? List<String>.from(data['images'].map((e) => e.toString().trim()))
        : [],
    reviews: data['reviews'] ?? [],
  );
}
}
