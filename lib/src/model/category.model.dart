// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart' show immutable;

@immutable
class FoodCategory {
  final String id;
  final String title;
  final String image;

  const FoodCategory({
    required this.id,
    required this.title,
    required this.image,
  });

  get price => null;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id' : id,
      'title': title,
      'image': image,
    };
  }

  factory FoodCategory.fromMap(Map<String, dynamic> map) {
    return FoodCategory(
      id: map['_id'] as String,
      title: map['title'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FoodCategory.fromJson(String source) =>
      FoodCategory.fromMap(json.decode(source) as Map<String, dynamic>);
}
