import 'package:contact_book/core/constants/styles.dart';
import 'package:contact_book/core/widgets/app_scaffold.dart';
import 'package:contact_book/core/widgets/bread_crumb.dart';
import 'package:contact_book/core/widgets/custom_button.dart';
import 'package:contact_book/core/widgets/custom_drop_down_menu.dart';
import 'package:contact_book/core/widgets/custom_email_form_field.dart';
import 'package:contact_book/core/widgets/custom_outline_button.dart';
import 'package:contact_book/core/widgets/custom_text_form_field.dart';
import 'package:contact_book/features/users/domain/entities/user_entity.dart';
import 'package:contact_book/features/users/presentation/blocs/users_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/custom_switch.dart';

// ignore: must_be_immutable
class InviteNewUserPage extends StatelessWidget {
  InviteNewUserPage({super.key});
  static const String name = 'Invite new user';
  final formKey = GlobalKey<FormState>();
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final userTypeController = TextEditingController();
  bool locked = false;
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const BreadCrumbNavigator(),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'User Details',
                          style: STYLES.TEXT_STYLE_18,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Unlocked',
                              style: STYLES.TEXT_STYLE_18,
                            ),
                            const SizedBox(width: 10),
                            CustomSwitch(
                              value: locked,
                              onChanged: (value) {
                                locked = !value;
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 24),
                    buildFrom(context)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Form buildFrom(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: CustomTextFromField(
                  isRequired: true,
                  labelText: 'First Name',
                  controller: fNameController,
                )),
                const SizedBox(width: 16),
                Expanded(
                    child: CustomTextFromField(
                  isRequired: true,
                  labelText: 'Last Name',
                  controller: lNameController,
                )),
              ],
            ),
            const SizedBox(height: 32),
            CustomEmailFormField(controller: emailController),
            const SizedBox(height: 32),
            CustomTextFromField(
              isRequired: true,
              labelText: 'Phone',
              keyboardType: TextInputType.phone,
              controller: phoneController,
            ),
            const SizedBox(height: 32),
            CustomDropDownMenu(
                controller: userTypeController,
                values: const ['User', 'Admin'],
                label: 'Select user type'),
            const SizedBox(height: 32),
            buildSaveButton(
              context,
            ),
            const SizedBox(height: 32),
            buildBackButton(context),
          ],
        ));
  }

  CustomOutlineButton buildBackButton(BuildContext context) =>
      CustomOutlineButton(
          child: const Text('Back'),
          onPressed: () {
            Navigator.pop(context);
          });

  CustomButton buildSaveButton(BuildContext context) => CustomButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            UserEntity user = UserEntity(
              lockoutEnabled: locked,
              email: emailController.text,
              phoneNumber: phoneController.text,
              firstName: fNameController.text,
              lastName: lNameController.text,
              role: userTypeController.text,
            );

            Navigator.pop(context);
            context.read<UsersBloc>().add(AddUserEvent(user: user));
          }
        },
        child: const Text('Save'),
      );
}
