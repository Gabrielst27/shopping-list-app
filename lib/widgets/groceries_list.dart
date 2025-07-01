import 'package:flutter/material.dart';
import 'package:shopping_list/data/list_items_dummy.dart';
import 'package:shopping_list/widgets/groceries_list_item.dart';

class GroceriesList extends StatelessWidget {
  const GroceriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listItemsDummy.length,
      itemBuilder: (context, index) =>
          GroceriesListItem(item: listItemsDummy[index]),
    );
  }
}
