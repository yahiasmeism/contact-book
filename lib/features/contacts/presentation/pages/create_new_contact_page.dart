import 'package:contact_book/features/contacts/presentation/widgets/create_new_contact_body.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/app_scaffold.dart';

class CreateNewContactPage extends StatelessWidget {
  const CreateNewContactPage({super.key});
  static const name = 'Create New';
  @override
  Widget build(BuildContext context) {
    return const AppScaffold(body: CreateNewContactBody(),);
  }
}
