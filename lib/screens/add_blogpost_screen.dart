import 'package:flutter/material.dart';
import 'package:personal_website/data/models/blogposts/blogpost_add.dart';
import 'package:personal_website/providers/blogpost_provider.dart';
import 'package:provider/provider.dart';

class AddBlogpostScreen extends StatefulWidget {
  const AddBlogpostScreen({super.key});

  @override
  State<AddBlogpostScreen> createState() => _AddBlogpostScreenState();
}

class _AddBlogpostScreenState extends State<AddBlogpostScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _credentialController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _credentialController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      await Provider.of<BlogpostProvider>(context, listen: false).addBlogpost(
        BlogpostAdd(
          title: _titleController.text,
          content: _contentController.text,
          postDate: _selectedDate!,
          credential: _credentialController.text,
        ),
      );
    }
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2025, 12, 31),
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Not like this works without admin perms'),
    ), //TODO return unauthorized for everything
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
              validator:
                  (String? value) =>
                      value == null || value.isEmpty ? 'Enter a title' : null,
            ),
            TextFormField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Content'),
              maxLines: 5,
              validator:
                  (String? value) =>
                      value == null || value.isEmpty ? 'Enter content' : null,
            ),
            TextFormField(
              controller: _credentialController,
              decoration: const InputDecoration(labelText: 'Credential'),
              validator: (String? value) =>
                  value == null || value.isEmpty ? 'Enter a credential' : null,
            ),
            Row(
              children: <Widget>[
                Text(
                  _selectedDate != null
                      ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                      : 'No date selected',
                ),
                const SizedBox(width: 20),
                OutlinedButton(
                  onPressed: _selectDate,
                  child: const Text('Select Date'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _submit, child: const Text('Add')),
          ],
        ),
      ),
    ),
  );
}
