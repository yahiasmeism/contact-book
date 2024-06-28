import 'package:contact_book/features/contacts/presentation/managers/contacts_bloc/contacts_bloc.dart';
import 'package:contact_book/features/contacts/presentation/widgets/contacts_list_view_pagination.dart';

import '../../../../core/widgets/snackbar_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'contacts_list_view.dart';

class ContactsBlocConsumer extends StatelessWidget {
  const ContactsBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactsBloc, ContactsState>(
      listener: (context, state) {
        if (state is ContactsFailure) {
          SnackBarGlobal.show(context, state.message, color: Colors.red);
        } else if (state is UserOperationSuccess) {
          SnackBarGlobal.show(context, state.message, color: Colors.green);
        }
      },
      builder: (context, state) {
        if (state is ContactsLoading) {
          return const SingleChildScrollView(
              child: Center(child: CircularProgressIndicator()));
        } else if (state is OnFilterContactsState) {
          return ContactsListView(contacts: state.contactsFilter);
        } else {
          final contacts = context.read<ContactsBloc>().contacts;
          return ContactListViewPgenation(contacts: contacts);
        }
      },
    );
  }
}
