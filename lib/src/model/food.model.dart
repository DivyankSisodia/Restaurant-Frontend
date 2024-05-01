// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart' show immutable;

@immutable
class Foods {
  final String id;
  final String title;
  final String description;
  final String price;
  final String image;
  final String rating;
  final String ratingCount;

  const Foods({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.rating,
    required this.ratingCount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'image': image,
      'rating': rating,
      'ratingCount': ratingCount,
    };
  }

  factory Foods.fromMap(Map<String, dynamic> map) {
    return Foods(
      id: map['_id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      price: map['price'] as String,
      image: map['image'] as String,
      rating: map['rating'] as String,
      ratingCount: map['ratingCount'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Foods.fromJson(String source) =>
      Foods.fromMap(json.decode(source) as Map<String, dynamic>);
}
