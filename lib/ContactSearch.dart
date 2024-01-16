import 'package:contact_manager/ContactList.dart';
import 'package:contact_manager/main.dart';
import 'package:flutter/material.dart';


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
