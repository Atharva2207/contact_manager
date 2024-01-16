import 'package:contact_manager/main.dart';
import 'package:flutter/material.dart';


class ContactCard extends StatelessWidget {
  final Contact contact;
  final Function(Contact) onEditContact;

  const ContactCard({
    required this.contact,
    required this.onEditContact,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        onTap: () {
          _showContactDetails(context, contact);
        },
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          contact.name,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          contact.phoneNumber,
          style: const TextStyle(fontSize: 14.0),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            _editContact(context);
          },
        ),
      ),
    );
  }

  void _editContact(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: contact.name);
    TextEditingController phoneNumberController =
        TextEditingController(text: contact.phoneNumber);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Contact'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: phoneNumberController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onEditContact(
                  Contact(
                    name: nameController.text,
                    phoneNumber: phoneNumberController.text,
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showContactDetails(BuildContext context, Contact contact) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Contact Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Name: ${contact.name}'),
              const SizedBox(height: 8.0),
              Text('Phone Number: ${contact.phoneNumber}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}