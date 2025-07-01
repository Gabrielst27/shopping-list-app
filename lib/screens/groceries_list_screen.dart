import 'package:flutter/material.dart';
import 'package:shopping_list/widgets/groceries_list.dart';

class GroceriesListScreen extends StatelessWidget {
  const GroceriesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Suas Compras')),
      body: GroceriesList(),
    );
  }
}
