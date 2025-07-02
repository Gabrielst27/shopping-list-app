import 'package:flutter/material.dart';
import 'package:shopping_list/screens/add_item_screen.dart';
import 'package:shopping_list/widgets/groceries_list.dart';

class GroceriesListScreen extends StatefulWidget {
  const GroceriesListScreen({super.key});

  @override
  State<GroceriesListScreen> createState() => _GroceriesListScreenState();
}

class _GroceriesListScreenState extends State<GroceriesListScreen> {
  void _addItem() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const AddItemScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suas Compras'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addItem,
          ),
        ],
      ),
      body: GroceriesList(),
    );
  }
}
