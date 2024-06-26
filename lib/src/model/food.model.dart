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
  final int quantity; // Added quantity field
  final String restaurantName;

  const Foods({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.rating,
    required this.ratingCount,
    required this.quantity,
    required this.restaurantName,
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
      quantity: map['quantity'] != null
          ? map['quantity'] as int
          : 1, // Provide default value for quantity
      restaurantName: map['restaurant']['title'] as String,
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
      'quantity': quantity,
      'restaurant': restaurantName
    };
  }

  String toJson() => json.encode(toMap());

  factory Foods.fromJson(String source) =>
      Foods.fromMap(json.decode(source) as Map<String, dynamic>);

  Foods copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? image,
    double? rating,
    int? ratingCount,
    int? quantity,
    String? restaurantName,
  }) {
    return Foods(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      ratingCount: ratingCount ?? this.ratingCount,
      quantity: quantity ?? this.quantity,
      restaurantName: restaurantName ?? this.restaurantName,
    );
  }
}
