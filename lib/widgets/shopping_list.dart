import 'package:flutter/material.dart';
import 'package:shopping_list/data/list_items_dummy.dart';
import 'package:shopping_list/widgets/shopping_list_item.dart';

class ShoppingList extends StatelessWidget {
  const ShoppingList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listItemsDummy.length,
      itemBuilder: (context, index) =>
          ShoppingListItem(item: listItemsDummy[index]),
    );
  }
}
