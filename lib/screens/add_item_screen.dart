import 'package:flutter/material.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicione um item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(child: Text('Formulário para adicionar um item')),
      ),
    );
  }
}
