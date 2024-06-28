import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:contact_book/core/widgets/bread_crumb.dart';
import 'package:contact_book/core/widgets/custom_button.dart';
import 'package:contact_book/features/contacts/presentation/pages/create_new_contact_page.dart';
import 'package:contact_book/features/contacts/presentation/pages/send_email_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_search_field.dart';
import '../managers/contacts_bloc/contacts_bloc.dart';
import 'contacts_bloc_consumer.dart';

class ContactsBody extends StatelessWidget {
  const ContactsBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          const SliverToBoxAdapter(child: BreadCrumbNavigator()),
          buildCreateNewButton(context),
          SliverToBoxAdapter(
            child: Row(
              children: [
                buildDeleteButton(context),
                const SizedBox(width: 16),
                buildExportToButton(context),
              ],
            ),
          ),
          buildSearchField(context),
          const SliverToBoxAdapter(child: ContactsBlocConsumer())
        ],
      ),
    );
  }

  Widget buildCreateNewButton(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: CustomButton(
          color: const Color(0xff28A745),
          child: const Text('Create New'),
          onPressed: () {
            Navigator.pushNamed(context, CreateNewContactPage.name);
          },
        ),
      ),
    );
  }

  Widget buildExportToButton(BuildContext context) {
    return Expanded(
      child: CustomButton(
        child: const Text('Send Email'),
        onPressed: () {
          Navigator.pushNamed(context, SendEmailPage.name);
        },
      ),
    );
  }

  Widget buildDeleteButton(BuildContext context) {
    final contactsBloc = context.read<ContactsBloc>();
    return Expanded(
      child: CustomButton(
        color: const Color(0xffFC766A),
        child: const Text('Delete'),
        onPressed: () {
          if (contactsBloc.contactsSelected.isNotEmpty) {
            AwesomeDialog(
              context: context,
              animType: AnimType.bottomSlide,
              dialogType: DialogType.warning,
              title:
                  'Are you sure to delete ${contactsBloc.contactsSelected.length} user',
              btnOkColor: Colors.red,
              btnCancelColor: COLORS.PRIMARY,
              btnCancelOnPress: () {},
              btnOkOnPress: () {
                context.read<ContactsBloc>().add(DeleteContactsEvent());
              },
            ).show();
          }
        },
      ),
    );
  }

  Widget buildSearchField(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: CustomSearchField(
          onChanged: (value) {
            if (value.isNotEmpty) {
              context
                  .read<ContactsBloc>()
                  .add(SearchContactsEvent(query: value));
            } else {
              context.read<ContactsBloc>().add(UndoSearchContactsEvent());
            }
          },
        ),
      ),
    );
  }
}
