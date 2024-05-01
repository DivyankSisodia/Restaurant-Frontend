import 'package:flutter/foundation.dart' show immutable;
import 'dart:convert';

@immutable
class Restaurants {
  final String id;
  final String title;
  final String imageUrl;
  final List<Map<String, dynamic>> foods; // Change here
  final String time;
  final int rating;
  final bool pickUp;
  final bool delivery;
  final bool isOpen;
  final String address;

  const Restaurants({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.foods,
    required this.time,
    required this.rating,
    required this.pickUp,
    required this.delivery,
    required this.isOpen,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'foods': foods,
      'time': time,
      'rating': rating,
      'pickUp': pickUp,
      'delivery': delivery,
      'isOpen': isOpen,
      'address': address,
    };
  }

  factory Restaurants.fromMap(Map<String, dynamic> map) {
    return Restaurants(
      id: map['_id'] as String,
      title: map['title'] as String,
      imageUrl: map['imageUrl'] as String,
      foods: List<Map<String, dynamic>>.from(
          map['foods'] as List<dynamic>), // Change here
      time: map['time'] as String,
      rating: map['rating'] as int,
      pickUp: map['pickUp'] as bool,
      delivery: map['delivery'] as bool,
      isOpen: map['isOpen'] as bool,
      address: map['address'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Restaurants.fromJson(String source) =>
      Restaurants.fromMap(json.decode(source) as Map<String, dynamic>);
}
