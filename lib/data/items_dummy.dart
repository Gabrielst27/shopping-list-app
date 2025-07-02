import 'package:shopping_list/data/categories_dummy.dart';
import 'package:shopping_list/model/grocery_item_model.dart';

final itemsDummy = [
  GroceryItemModel(
    name: 'Coca-Cola',
    category: categoriesDummy.firstWhere((c) => c.name == 'drink'),
    quantity: 2,
  ),
  GroceryItemModel(
    name: 'Banana',
    category: categoriesDummy.firstWhere((c) => c.name == 'fruit'),
    quantity: 6,
  ),
  GroceryItemModel(
    name: 'Chocolate',
    category: categoriesDummy.firstWhere((c) => c.name == 'sweet'),
    quantity: 3,
  ),
  GroceryItemModel(
    name: 'Salt',
    category: categoriesDummy.firstWhere((c) => c.name == 'spices'),
    quantity: 1,
  ),
  GroceryItemModel(
    name: 'Pizza',
    category: categoriesDummy.firstWhere((c) => c.name == 'convenience'),
    quantity: 2,
  ),
];
