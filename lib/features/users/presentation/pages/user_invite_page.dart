import 'package:contact_book/core/widgets/app_scaffold.dart';
import 'package:contact_book/core/widgets/bread_crumb.dart';
import 'package:contact_book/core/widgets/custom_button.dart';
import 'package:contact_book/core/widgets/custom_outline_button.dart';
import 'package:contact_book/features/users/domain/entities/user_entity.dart';
import 'package:contact_book/features/users/presentation/widgets/user_details_form_.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/users_bloc.dart';

class UserInvitePage extends StatelessWidget {
  const UserInvitePage({super.key});
  static const name = 'Invite new user';
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final fNameController = TextEditingController();
    final lNameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final roleController = TextEditingController();
    return AppScaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const BreadCrumbNavigator(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      UserDetailsForm(
                        formKey: formKey,
                        fNameController: fNameController,
                        lNameController: lNameController,
                        emailController: emailController,
                        phoneController: phoneController,
                        roleController: roleController,
                      ),
                      const SizedBox(height: 32),
                      builSaveButton(
                        formKey,
                        emailController,
                        phoneController,
                        fNameController,
                        lNameController,
                        roleController,
                        context,
                      ),
                      const SizedBox(height: 32),
                      buildBackButton(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget builSaveButton(
      GlobalKey<FormState> formKey,
      TextEditingController emailController,
      TextEditingController phoneController,
      TextEditingController fNameController,
      TextEditingController lNameController,
      TextEditingController roleController,
      BuildContext context) {
    return CustomButton(
      child: const Text('Save'),
      onPressed: () {
        if (formKey.currentState?.validate() == true) {
          final user = UserEntity(
            email: emailController.text,
            phoneNumber: phoneController.text,
            firstName: fNameController.text,
            lastName: lNameController.text,
            role: roleController.text,
          );
          context.read<UsersBloc>().add(AddUserEvent(user: user));
          Navigator.pop(context);
        }
      },
    );
  }

  Widget buildBackButton(BuildContext context) {
    return CustomOutlineButton(
      child: const Text('Back'),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
