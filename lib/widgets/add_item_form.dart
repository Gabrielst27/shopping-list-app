import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories_dummy.dart';
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

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context).pop(
        GroceryItemModel(
          name: _enteredName,
          category: _selectedCategory,
          quantity: _enteredQuantity,
        ),
      );
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
            onChanged: (value) => _formKey.currentState!.validate(),
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
                  onChanged: (value) => _formKey.currentState!.validate(),
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
                  onChanged: (value) => _formKey.currentState!.validate(),
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
