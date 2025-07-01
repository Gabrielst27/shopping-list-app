import 'package:flutter/material.dart';
import 'package:shopping_list/screens/shopping_list_screen.dart';
import 'package:shopping_list/theme.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: theme, home: ShoppingListScreen());
  }
}
