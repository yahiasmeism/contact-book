import 'package:contact_book/features/contacts/presentation/widgets/contact_tile.dart';
import 'package:contact_book/features/contacts/domain/entities/contact_entity.dart';
import 'package:flutter/material.dart';

class ContactsListView extends StatelessWidget {
  const ContactsListView({
    super.key,
    required this.contacts,
  });
  final List<ContactEntity> contacts;
  @override
  Widget build(BuildContext context) {
    if (contacts.isNotEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: Colors.white,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            return ContactTile(contact: contacts[index]);
          },
        ),
      );
    } else {
      return const Center(child: Text('No Contacts'));
    }
  }
}
