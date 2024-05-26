// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/foundation.dart' show immutable;
import 'package:hive_flutter/hive_flutter.dart';

part 'favorite_restaurant.g.dart';

@immutable
@HiveType(typeId: 1)
class FavRestaurantModel extends HiveObject {

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String imageUrl;

  @HiveField(3)
  final int rating;

  @HiveField(4)
  final String time;

  @HiveField(5)
  final String address;

  FavRestaurantModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.rating,
    required this.time,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'rating': rating,
      'time': time,
      'address': address,
    };
  }

  factory FavRestaurantModel.fromMap(Map<String, dynamic> map) {
    return FavRestaurantModel(
      id: map['id'],
      title: map['title'],
      imageUrl: map['imageUrl'],
      rating: map['rating'],
      time: map['time'],
      address: map['address'],
    );
  }
  factory FavRestaurantModel.fromJson(String source) =>
      FavRestaurantModel.fromMap(json.decode(source) as Map<String, dynamic>);

      FavRestaurantModel copyWith({
    String? id,
    String? title,
    String? imageUrl,
    int? rating,
    String? time,
    String? address,
  }) {
    return FavRestaurantModel(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      time: time ?? this.time,
      address: address ?? this.address,
    );
  }
}
