import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories_dummy.dart';

class AddItemForm extends StatefulWidget {
  const AddItemForm({super.key});

  @override
  State<AddItemForm> createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            maxLength: 50,
            decoration: const InputDecoration(label: Text('Nome')),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira o nome do item.';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Quantidade'),
                  ),
                  initialValue: 1.toString(),
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: DropdownButtonFormField(
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
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: () {}, child: const Text('Cancelar')),
              ElevatedButton(onPressed: () {}, child: const Text('Salvar')),
            ],
          ),
        ],
      ),
    );
  }
}
