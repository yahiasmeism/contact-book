import 'package:contact_book/core/widgets/app_scaffold.dart';
import 'package:contact_book/features/contacts/domain/entities/contact_entity.dart';
import 'package:flutter/material.dart';

import '../widgets/details/contact_details_body.dart';

class ContactDetailsPage extends StatelessWidget {
  const ContactDetailsPage({super.key});
  static const name = 'Contact Details';
  @override
  Widget build(BuildContext context) {
    final contact = ModalRoute.of(context)?.settings.arguments as ContactEntity;
    return AppScaffold(
      body: ContactDetailsBody(contact: contact),
    );
  }
}
