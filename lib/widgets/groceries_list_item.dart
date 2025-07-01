import 'package:flutter/material.dart';
import 'package:shopping_list/model/grocery_item_model.dart';

class GroceriesListItem extends StatelessWidget {
  const GroceriesListItem({super.key, required this.item});

  final GroceryItemModel item;

  @override
  Widget build(BuildContext context) {
    final itemColor = categoryColors[item.category];
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: itemColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 16),
                Text(item.name),
              ],
            ),
          ),
          Text(item.quantity.toString()),
        ],
      ),
    );
  }
}
