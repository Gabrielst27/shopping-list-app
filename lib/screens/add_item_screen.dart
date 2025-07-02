import 'package:flutter/material.dart';
import 'package:shopping_list/widgets/add_item_form.dart';

class AddItemScreen extends StatelessWidget {
  const AddItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicione um item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: const AddItemForm(),
      ),
    );
  }
}
