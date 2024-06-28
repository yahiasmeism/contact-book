import 'package:contact_book/features/contacts/domain/entities/contact_entity.dart';
import 'package:contact_book/features/contacts/presentation/widgets/contacts_list_view.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_pagenation.dart';

class ContactListViewPgenation extends StatefulWidget {
  const ContactListViewPgenation({
    super.key,
    required this.contacts,
  });
  final List<ContactEntity> contacts;
  @override
  State<ContactListViewPgenation> createState() =>
      _ContactsListViewPaginationState();
}

class _ContactsListViewPaginationState extends State<ContactListViewPgenation> {
  @override
  Widget build(BuildContext context) {
    int totalPages = (widget.contacts.length / usersPerPage).ceil();
    if (widget.contacts.isNotEmpty) {
      return Column(
        children: [
          ContactsListView(contacts: currentPageContacts),
          const SizedBox(height: 24),
          CustomPagenation(
            totalPages: totalPages,
            currentPage: currentPage,
            onPageChange: (pageIndex) {
              setState(() {
                currentPage = pageIndex;
              });
            },
          ),
          const SizedBox(height: 24),
        ],
      );
    } else {
      return const Center(child: Text('No Contacts'));
    }
  }

  int currentPage = 0;
  final int usersPerPage = 4;
  List<ContactEntity> get currentPageContacts {
    /// extract the starting Index By multilplying
    /// the current page by the users on the page
    final startIndex = currentPage * usersPerPage;

    /// extract the end Index By adding
    /// the start index to the users on the page
    final endIndex = startIndex + usersPerPage;

    /// return users in the current page
    final users = widget.contacts.sublist(
      startIndex,

      /// check the endIndex to avoid an out Range Exception
      endIndex > widget.contacts.length ? widget.contacts.length : endIndex,
    );
    return users;
  }
}
