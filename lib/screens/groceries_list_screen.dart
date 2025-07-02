import 'package:flutter/material.dart';
import 'package:shopping_list/model/grocery_item_model.dart';
import 'package:shopping_list/screens/add_item_screen.dart';
import 'package:shopping_list/widgets/groceries_list.dart';

class GroceriesListScreen extends StatefulWidget {
  const GroceriesListScreen({super.key});

  @override
  State<GroceriesListScreen> createState() => _GroceriesListScreenState();
}

class _GroceriesListScreenState extends State<GroceriesListScreen> {
  final List<GroceryItemModel> _groceryItems = [];

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItemModel>(
      MaterialPageRoute(builder: (context) => const AddItemScreen()),
    );
    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItems.add(newItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Text(
        'Nenhum item adicionado.',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
    if (_groceryItems.isNotEmpty) {
      content = GroceriesList(items: _groceryItems);
    }
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
      body: content,
    );
  }
}
