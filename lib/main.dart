import 'package:flutter/material.dart';
import 'package:hello/add_item_screen.dart';
import 'package:hello/edit_screen_item.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<String> _items = List<String>.generate(20, (i) => "Item $i");

  void _deleteItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  void _addItem(String newItem) {
    setState(() {
      _items.add(newItem);
    });
  }

  void _editItem(int index, String newItem) {
    setState(() {
      _items[index] = newItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Items'),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              _items[index],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditItemScreen(
                          initialText: _items[index],
                          onEditItem: (newItem) => _editItem(index, newItem),
                        ),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteItem(index),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(item: _items[index]),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddItemScreen(onAddItem: _addItem),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String item;

  const DetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item),
      ),
      body: Center(
        child: Text('Details of $item'),
      ),
    );
  }
}
