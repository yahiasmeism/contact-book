import 'package:contact_book/core/widgets/app_scaffold.dart';
import 'package:contact_book/features/contacts/presentation/managers/send_email_cubit/send_email_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/snackbar_global.dart';
import '../managers/contacts_bloc/contacts_bloc.dart';
import '../widgets/contacts_body.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});
  static const name = 'Contacts';
  @override
  Widget build(BuildContext context) {
    return BlocListener<SendEmailCubit, SendEmailState>(
      listener: (context, state) {
        if (state is SendEmailFilure) {
          SnackBarGlobal.show(context, state.message, color: Colors.red);
        } else if (state is SendEmailSuccess) {
          SnackBarGlobal.show(context, state.message, color: Colors.green);
        }
      },
      child: AppScaffold(
        body: RefreshIndicator(
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          onRefresh: () async {
            context.read<ContactsBloc>().add(GetAllContactsEvent());
          },
          child: const ContactsBody(),
        ),
      ),
    );
  }
}
