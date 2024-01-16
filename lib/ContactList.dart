import 'package:contact_manager/ContactCard.dart';
import 'package:contact_manager/main.dart';
import 'package:flutter/material.dart';

//import 'add_contact_screen.dart';

class ContactList extends StatelessWidget {
  final List<Contact> contacts;
  final Function(Contact, Contact) onEditContact;

  const ContactList({
    required this.contacts,
    required this.onEditContact,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        return ContactCard(
          contact: contacts[index],
          onEditContact: (newContact) =>
              onEditContact(contacts[index], newContact),
        );
      },
    );
  }
}