import 'package:uuid/uuid.dart';

enum ECategory { liquid, fruit, candy, salad, meal }

class ListItemModel {
  ListItemModel({
    required this.name,
    required this.category,
    required this.quantity,
  }) : id = Uuid().v4();

  final String id;
  final String name;
  final ECategory category;
  final int quantity;
}
