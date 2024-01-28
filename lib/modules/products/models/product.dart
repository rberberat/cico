import 'package:flutter/foundation.dart';

@immutable
class Product {
  final String name;
  final int caloriesPer100g;

  const Product({required this.name, required this.caloriesPer100g});

  Product.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        caloriesPer100g = json['caloriesPer100g'] as int;

  Map<String, dynamic> toJson() => {'name': name, 'caloriesPer100g': caloriesPer100g};

  Product copyWith(String? name, int? caloriesPer100g) {
    return Product(
      name: name ?? this.name,
      caloriesPer100g: caloriesPer100g ?? this.caloriesPer100g,
    );
  }

  double caloriesIn(int gramms) => gramms / 100 * caloriesPer100g;
}
