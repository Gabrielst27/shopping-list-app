import 'package:shopping_list/data/categories_dummy.dart';
import 'package:shopping_list/model/grocery_item_model.dart';

final itemsDummy = [
  GroceryItemModel(
    name: 'Coca-Cola',
    category: categoriesDummy.firstWhere((c) => c.name == 'Bebidas'),
    quantity: 2,
  ),
  GroceryItemModel(
    name: 'Banana',
    category: categoriesDummy.firstWhere((c) => c.name == 'Frutas'),
    quantity: 6,
  ),
  GroceryItemModel(
    name: 'Chocolate',
    category: categoriesDummy.firstWhere((c) => c.name == 'Doces'),
    quantity: 3,
  ),
  GroceryItemModel(
    name: 'Salt',
    category: categoriesDummy.firstWhere((c) => c.name == 'Temperos'),
    quantity: 1,
  ),
  GroceryItemModel(
    name: 'Pizza',
    category: categoriesDummy.firstWhere((c) => c.name == 'Conveniências'),
    quantity: 2,
  ),
];
