import 'package:flutter/material.dart';

class AddItemScreen extends StatefulWidget {
  final Function(String) onAddItem;

  const AddItemScreen({super.key, required this.onAddItem});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onAddItem(_controller.text);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Item Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an item name';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Add Item'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
