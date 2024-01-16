import 'package:contact_manager/AddContactScreen.dart';
import 'package:contact_manager/ContactList.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    themeMode: ThemeMode.system,
    theme: ThemeData.light(),
    darkTheme: ThemeData.dark(),
    home: ContactManagerApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class Contact {
  final String name;
  final String phoneNumber;

  Contact({required this.name, required this.phoneNumber});
}

class ContactManagerApp extends StatefulWidget {
  @override
  _ContactManagerAppState createState() => _ContactManagerAppState();
}

class _ContactManagerAppState extends State<ContactManagerApp> {
  List<Contact> contacts = [
    Contact(name: 'Atharva', phoneNumber: '1234567890'),
    Contact(name: 'Shree', phoneNumber: '9876543210'),
    Contact(name: 'Prashant', phoneNumber: '5551234567'),
    Contact(name: 'Gauri', phoneNumber: '4445678901'),
    Contact(name: 'Sahil', phoneNumber: '4445556789'),
    Contact(name: 'Rohan', phoneNumber: '1112223333'),
  ];

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ContactSearchDelegate(contacts),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'call_history') {
                _showDialog('Call History', 'Call history placeholder');
              } else if (value == 'settings') {
                // Show settings
              } else if (value == 'help_feedback') {
                // Show help and feedback
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'call_history',
                  child: Text('Call History'),
                ),
                const PopupMenuItem<String>(
                  value: 'settings',
                  child: Text('Settings'),
                ),
                const PopupMenuItem<String>(
                  value: 'help_feedback',
                  child: Text('Help and Feedback'),
                ),
              ];
            },
          ),
        ],
      ),
      body: ContactList(
        contacts: contacts,
        onEditContact: _editContact,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddContactScreen(onContactAdded: _addContact),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addContact(Contact newContact) {
    setState(() {
      contacts.add(newContact);
    });
  }

  void _editContact(Contact oldContact, Contact newContact) {
    setState(() {
      contacts.remove(oldContact);
      contacts.add(newContact);
    });
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
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

class ContactSearchDelegate extends SearchDelegate<Contact> {
  final List<Contact> contacts;

  ContactSearchDelegate(this.contacts);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, Contact(name: '', phoneNumber: ''));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Contact> results = contacts
        .where((contact) =>
            contact.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ContactList(
      contacts: results,
      onEditContact: (oldContact, newContact) {},
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Contact> suggestions = contacts
        .where((contact) =>
            contact.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ContactList(
      contacts: suggestions,
      onEditContact: (oldContact, newContact) {},
    );
  }
}
