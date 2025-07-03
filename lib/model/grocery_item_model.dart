import 'package:shopping_list/model/category_model.dart';

class GroceryItemModel {
  GroceryItemModel({
    required this.id,
    required this.name,
    required this.category,
    required this.quantity,
  });

  final String id;
  final String name;
  final Category category;
  final int quantity;
}
