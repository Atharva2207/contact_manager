import 'package:contact_manager/main.dart';
import 'package:flutter/material.dart';


class AddContactScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final Function(Contact) onContactAdded;

  AddContactScreen({required this.onContactAdded});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: phoneNumberController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text;
                String phoneNumber = phoneNumberController.text;
                Contact newContact =
                    Contact(name: name, phoneNumber: phoneNumber);
                onContactAdded(newContact);
              },
              child: const Text('Add Contact'),
            ),
          ],
        ),
      ),
    );
  }
}