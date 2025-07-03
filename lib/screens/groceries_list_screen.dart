import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/data/categories_dummy.dart';
import 'package:shopping_list/environment.dart';
import 'package:shopping_list/model/grocery_item_model.dart';
import 'package:shopping_list/screens/add_item_screen.dart';
import 'package:shopping_list/widgets/groceries_list.dart';

class GroceriesListScreen extends StatefulWidget {
  const GroceriesListScreen({super.key});

  @override
  State<GroceriesListScreen> createState() => _GroceriesListScreenState();
}

class _GroceriesListScreenState extends State<GroceriesListScreen> {
  List<GroceryItemModel> _groceryItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getItems();
  }

  void _getItems() async {
    final Uri url = Uri.https(
      apiUrl
          .split('https://')[1]
          .replaceFirst('https://', '')
          .trimRight()
          .replaceAll(RegExp(r'/$'), ''),
      'shooping-list.json',
    );
    final response = await http.get(url);
    final Map<String, dynamic> listData = json.decode(response.body);
    final List<GroceryItemModel> loadedItems = [];
    for (final data in listData.entries) {
      final category = categoriesDummy.firstWhere(
        (cat) => cat.name == data.value['category'],
      );
      loadedItems.add(
        GroceryItemModel(
          id: data.key,
          name: data.value['name'],
          category: category,
          quantity: data.value['quantity'],
        ),
      );
    }
    setState(() {
      _groceryItems = loadedItems;
      _isLoading = false;
    });
  }

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

  void _removeItem(GroceryItemModel item) {
    int groceryIndex = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.remove(item);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Text('Item removido'),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
            setState(() {
              _groceryItems.insert(groceryIndex, item);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Text(
        'Nenhum item adicionado.',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    } else if (_groceryItems.isNotEmpty) {
      content = GroceriesList(
        items: _groceryItems,
        onDismiss: _removeItem,
      );
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
