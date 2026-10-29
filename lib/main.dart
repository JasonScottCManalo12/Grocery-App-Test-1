import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const GroceryApp());
}

class GroceryApp extends StatelessWidget {
  const GroceryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocery App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const GroceryHomePage(),
    );
  }
}

class GroceryHomePage extends StatefulWidget {
  const GroceryHomePage({super.key});

  @override
  State<GroceryHomePage> createState() => _GroceryHomePageState();
}

class _GroceryHomePageState extends State<GroceryHomePage> {
  final List<GroceryItem> _items = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  bool _isLoading = true;

  static const List<String> _categories = [
    'Fruits',
    'Vegetables',
    'Dairy',
    'Meat & Fish',
    'Bakery',
    'Snacks',
    'Beverages',
    'Household',
    'Personal Care',
    'Other',
  ];

  String _selectedCategory = 'Other';

  static const String _storageKey = 'grocery_items';

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(_storageKey);

    if (jsonString != null && jsonString.isNotEmpty) {
      final List<dynamic> decoded = jsonDecode(jsonString);
      setState(() {
        _items.clear();
        _items.addAll(
          decoded.map((e) => GroceryItem.fromJson(e as Map<String, dynamic>)),
        );
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonString = jsonEncode(
      _items.map((item) => item.toJson()).toList(),
    );
    await prefs.setString(_storageKey, jsonString);
  }

  void _addItem() {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    final quantityText = _quantityController.text.trim();
    final quantity = quantityText.isEmpty ? '1' : quantityText;

    setState(() {
      _items.add(GroceryItem(
        name: name,
        quantity: quantity,
        category: _selectedCategory,
      ));
      _nameController.clear();
      _quantityController.clear();
      _selectedCategory = 'Other';
    });
    _saveItems();
  }

  void _toggleBought(int index) {
    setState(() {
      _items[index].isBought = !_items[index].isBought;
    });
    _saveItems();
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
    _saveItems();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery List'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          hintText: 'Item name (e.g. Milk)',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.shopping_cart),
                        ),
                        onSubmitted: (_) => _addItem(),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _quantityController,
                              decoration: const InputDecoration(
                                hintText: 'Qty (e.g. 2, 1kg)',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.numbers),
                              ),
                              onSubmitted: (_) => _addItem(),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _selectedCategory,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 16,
                                ),
                              ),
                              items: _categories.map((String category) {
                                return DropdownMenuItem<String>(
                                  value: category,
                                  child: Text(
                                    category,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    _selectedCategory = newValue;
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: _addItem,
                          icon: const Icon(Icons.add),
                          label: const Text('Add Item'),
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _items.isEmpty
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_basket_outlined,
                                size: 80,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Your grocery list is empty',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Add items above to get started',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: _items.length,
                          itemBuilder: (context, index) {
                            final item = _items[index];
                            return Dismissible(
                              key: Key('${item.name}_$index'),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 20),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              onDismissed: (_) => _removeItem(index),
                              child: Card(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 4,
                                ),
                                child: ListTile(
                                  leading: Checkbox(
                                    value: item.isBought,
                                    onChanged: (_) => _toggleBought(index),
                                  ),
                                  title: Text(
                                    item.name,
                                    style: TextStyle(
                                      decoration: item.isBought
                                          ? TextDecoration.lineThrough
                                          : null,
                                      color: item.isBought ? Colors.grey : null,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Qty: ${item.quantity}  ·  ${item.category}',
                                    style: TextStyle(
                                      color: item.isBought
                                          ? Colors.grey
                                          : Colors.black54,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                    ),
                                    onPressed: () => _removeItem(index),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}

class GroceryItem {
  final String name;
  final String quantity;
  final String category;
  bool isBought;

  GroceryItem({
    required this.name,
    this.quantity = '1',
    this.category = 'Other',
    this.isBought = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'category': category,
      'isBought': isBought,
    };
  }

  factory GroceryItem.fromJson(Map<String, dynamic> json) {
    return GroceryItem(
      name: json['name'] as String,
      quantity: json['quantity'] as String? ?? '1',
      category: json['category'] as String? ?? 'Other',
      isBought: json['isBought'] as bool? ?? false,
    );
  }
}
