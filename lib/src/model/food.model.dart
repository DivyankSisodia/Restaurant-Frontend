import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class Foods {
  final String id;
  final String title;
  final String description;
  final double price;
  final String image;
  final double rating; // Changed type to double
  final int ratingCount; // Changed type to int

  const Foods({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.rating,
    required this.ratingCount,
  });

  factory Foods.fromMap(Map<String, dynamic> map) {
    return Foods(
      id: map['_id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      price: (map['price'] as num).toDouble(),
      image: map['image'] as String,
      rating: (map['rating'] as num).toDouble(), // Parse rating as double
      ratingCount: map['ratingCount'] as int, // Parse ratingCount as int
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id, // Update to match MongoDB naming convention
      'title': title,
      'description': description,
      'price': price,
      'image': image,
      'rating': rating,
      'ratingCount': ratingCount,
    };
  }

  String toJson() => json.encode(toMap());

  factory Foods.fromJson(String source) =>
      Foods.fromMap(json.decode(source) as Map<String, dynamic>);
}
