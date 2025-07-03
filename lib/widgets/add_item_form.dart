import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/data/categories_dummy.dart';
import 'package:shopping_list/environment.dart';
import 'package:shopping_list/model/category_model.dart';
import 'package:shopping_list/model/grocery_item_model.dart';

class AddItemForm extends StatefulWidget {
  const AddItemForm({super.key});

  @override
  State<AddItemForm> createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  final _formKey = GlobalKey<FormState>();
  String _enteredName = '';
  int _enteredQuantity = 1;
  Category _selectedCategory = categoriesDummy[0];

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final Uri url = Uri.https(
        apiUrl
            .split('https://')[1]
            .replaceFirst('https://', '')
            .trimRight()
            .replaceAll(RegExp(r'/$'), ''),
        'shooping-list.json',
      );
      final response = await http.post(
        url,
        headers: {
          'Content-type': 'application/json',
        },
        body: json.encode({
          'name': _enteredName,
          'category': _selectedCategory.name,
          'quantity': _enteredQuantity,
        }),
      );
      if (response.statusCode.toString().startsWith('4')) {
        if (!context.mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar item: ${response.statusCode}'),
          ),
        );
      }
      if (response.statusCode.toString().startsWith('2')) {
        if (!context.mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Item adicionado com sucesso!'),
          ),
        );
        final Map<String, dynamic> responseData = json.decode(response.body);
        Navigator.of(context).pop(
          GroceryItemModel(
            id: responseData['name'],
            name: _enteredName,
            category: _selectedCategory,
            quantity: _enteredQuantity,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            maxLength: 50,
            decoration: const InputDecoration(label: Text('Nome')),
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  value.trim().length <= 1 ||
                  value.trim().length > 50) {
                return 'Deve conter entre 2 e 50 caracteres.';
              }
              return null;
            },
            onSaved: (value) => _enteredName = value!.trim(),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Quantidade'),
                    errorMaxLines: 3,
                    errorStyle: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  initialValue: 1.toString(),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.tryParse(value) == null ||
                        int.tryParse(value)! <= 0) {
                      return 'Deve ser um número inteiro positivo maior que 0.';
                    }
                    return null;
                  },
                  onSaved: (value) => _enteredQuantity = int.parse(value!),
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: DropdownButtonFormField(
                  validator: (value) {
                    if (value == null) {
                      return 'Selecione uma categoria.';
                    }
                    return null;
                  },
                  items: [
                    for (final category in categoriesDummy)
                      DropdownMenuItem(
                        value: category,
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: category.color,
                              ),
                            ),
                            Text(
                              category.name,
                            ),
                          ],
                        ),
                      ),
                  ],
                  onChanged: (value) {},
                  onSaved: (value) => _selectedCategory = value as Category,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  _formKey.currentState!.reset();
                  Navigator.of(context).pop();
                },
                child: const Text('Cancelar'),
              ),
              ElevatedButton(onPressed: _saveItem, child: const Text('Salvar')),
            ],
          ),
        ],
      ),
    );
  }
}
