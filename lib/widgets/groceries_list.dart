import 'package:flutter/material.dart';
import 'package:shopping_list/data/items_dummy.dart';
import 'package:shopping_list/widgets/groceries_list_item.dart';

class GroceriesList extends StatelessWidget {
  const GroceriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemsDummy.length,
      itemBuilder: (context, index) =>
          GroceriesListItem(grocery: itemsDummy[index]),
    );
  }
}
