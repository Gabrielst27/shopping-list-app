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
  String? _error;

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
      'shopping-list.json',
    );
    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        if (!context.mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao carregar itens: ${response.statusCode}'),
          ),
        );
        setState(() {
          _isLoading = false;
        });
        return;
      }
      if (response.body == 'null' ||
          response.body.isEmpty ||
          response.body == '{}') {
        setState(() {
          _groceryItems = [];
          _isLoading = false;
        });
        return;
      }
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
    } catch (error) {
      setState(() {
        _isLoading = false;
        _error = 'Erro ao carregar itens. Tente novamente mais tarde.';
      });
    }
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

  void _removeItem(GroceryItemModel item) async {
    int groceryIndex = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.remove(item);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    final snackBarController = ScaffoldMessenger.of(context).showSnackBar(
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
    await snackBarController.closed;
    if (!_groceryItems.contains(item)) {
      final Uri url = Uri.https(
        apiUrl
            .split('https://')[1]
            .replaceFirst('https://', '')
            .trimRight()
            .replaceAll(RegExp(r'/$'), ''),
        'shopping-list/${item.id}.json',
      );
      final response = await http.delete(url);
      if (response.statusCode.toString().startsWith('4')) {
        if (!context.mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao remover item: ${response.statusCode}'),
          ),
        );
        setState(() {
          _groceryItems.insert(groceryIndex, item);
        });
        return;
      }
    }
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
    if (_error != null) {
      content = Center(
        child: Text(
          _error!,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
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
