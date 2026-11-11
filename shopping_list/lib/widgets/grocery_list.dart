import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final url = Uri.https(
      'flutter-apps-6cb82-default-rtdb.asia-southeast1.firebasedatabase.app',
      '/shopping-list.json',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode >= 400) {
        throw Exception('Failed to load grocery items: ${response.statusCode}');
      }

      if (response.body == 'null') {
        if (!mounted) {
          return;
        }
        setState(() {
          _groceryItems = [];
        });
        return;
      }

      final Map<String, dynamic> listData = json.decode(response.body);
      final loadedItems = <GroceryItem>[];

      for (final item in listData.entries) {
        final categoryEntry = categories.entries.firstWhere(
          (entry) => entry.value.title == item.value['category'],
          orElse: () => categories.entries.first,
        );

        loadedItems.add(
          GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: categoryEntry.value,
          ),
        );
      }

      if (!mounted) {
        return;
      }

      setState(() {
        _groceryItems = loadedItems;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _groceryItems = [];
      });
    }
  }

  Future<void> _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(builder: (ctx) => const NewItem()),
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
    Widget content = ListView.builder(
      itemCount: _groceryItems.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(_groceryItems[index].id),
        child: ListTile(
          title: Text(_groceryItems[index].name),
          leading: Container(
            width: 24,
            height: 24,
            color: _groceryItems[index].category.color,
          ),
          trailing: Text(
            _groceryItems[index].quantity.toString(),
          ),
        ),
      ),
    );

    if (_groceryItems.isEmpty) {
      content = const Center(
        child: Text('No items added yet.'),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
