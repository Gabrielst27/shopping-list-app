import 'package:flutter/material.dart';
import 'package:shopping_list/widgets/shopping_list.dart';

class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Suas Compras')),
      body: ShoppingList(),
    );
  }
}
