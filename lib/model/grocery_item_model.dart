import 'package:shopping_list/model/category_model.dart';
import 'package:uuid/uuid.dart';

class GroceryItemModel {
  GroceryItemModel({
    required this.name,
    required this.category,
    required this.quantity,
  }) : id = Uuid().v4();

  final String id;
  final String name;
  final Category category;
  final int quantity;
}
