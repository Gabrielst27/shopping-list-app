import 'package:flutter/material.dart';
import 'package:shopping_list/model/grocery_item_model.dart';

class GroceriesListItem extends StatelessWidget {
  const GroceriesListItem({
    super.key,
    required this.grocery,
    required this.onDismiss,
  });

  final GroceryItemModel grocery;

  final void Function(GroceryItemModel item) onDismiss;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(grocery.id),
      onDismissed: (_) {
        onDismiss(grocery);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: ListTile(
          title: Text(grocery.name),
          leading: Container(
            width: 24,
            height: 24,
            color: grocery.category.color,
          ),
          trailing: Text(
            grocery.quantity.toString(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}
