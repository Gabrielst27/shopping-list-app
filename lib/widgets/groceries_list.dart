import 'package:flutter/material.dart';
import 'package:shopping_list/model/grocery_item_model.dart';
import 'package:shopping_list/widgets/groceries_list_item.dart';

class GroceriesList extends StatelessWidget {
  const GroceriesList({
    super.key,
    required this.items,
    required this.onDismiss,
  });

  final List<GroceryItemModel> items;
  final void Function(GroceryItemModel item) onDismiss;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (ctx, index) => GroceriesListItem(
        grocery: items[index],
        onDismiss: onDismiss,
      ),
    );
  }
}
