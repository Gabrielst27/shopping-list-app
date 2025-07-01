import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

enum ECategory { liquid, fruit, candy, salad, meal }

final Map<ECategory, Color> categoryColors = {
  ECategory.liquid: const Color.fromARGB(255, 0, 195, 255),
  ECategory.fruit: const Color.fromARGB(255, 238, 255, 1),
  ECategory.candy: const Color.fromARGB(255, 249, 87, 255),
  ECategory.salad: const Color.fromARGB(255, 8, 255, 140),
  ECategory.meal: const Color.fromARGB(255, 165, 91, 22),
};

class GroceryItemModel {
  GroceryItemModel({
    required this.name,
    required this.category,
    required this.quantity,
  }) : id = Uuid().v4();

  final String id;
  final String name;
  final ECategory category;
  final int quantity;
}
