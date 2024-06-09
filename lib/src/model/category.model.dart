// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart' show immutable;
import 'package:hive_flutter/hive_flutter.dart';

part 'Hive/category.model.g.dart';

@immutable
@HiveType(typeId: 2)
class FoodCategory {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
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
