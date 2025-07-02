import 'package:flutter/material.dart';

class Category {
  const Category({required this.name, required this.color});

  final String name;
  final Color color;
}

enum ECategory { drink, fruit, candy, salad, meal, meat, hygiene, other }
