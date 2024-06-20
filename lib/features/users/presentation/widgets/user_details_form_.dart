import 'package:contact_book/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/styles.dart';
import '../../../../core/widgets/custom_drop_down_menu.dart';
import '../../../../core/widgets/custom_email_form_field.dart';
import '../../../../core/widgets/custom_switch.dart';

class UserDetailsForm extends StatelessWidget {
  const UserDetailsForm({
    super.key,
    required this.formKey,
    required this.fNameController,
    required this.lNameController,
    required this.emailController,
    required this.phoneController,
    required this.roleController,
    this.enabled = true,
  });
  final GlobalKey<FormState> formKey;

  final TextEditingController fNameController;

  final TextEditingController lNameController;

  final TextEditingController emailController;

  final TextEditingController phoneController;

  final TextEditingController roleController;

  final bool enabled;
  @override
  Widget build(BuildContext context) {
    bool unlocked = false;
    return Column(
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
                  value: unlocked,
                  onChanged: (value) {},
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 32),
        Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: CustomTextFromField(
                      enabled: enabled,
                      isRequired: true,
                      labelText: 'First Name',
                      controller: fNameController,
                    )),
                    const SizedBox(width: 16),
                    Expanded(
                        child: CustomTextFromField(
                      enabled: enabled,
                      isRequired: true,
                      labelText: 'Last Name',
                      controller: lNameController,
                    )),
                  ],
                ),
                const SizedBox(height: 32),
                CustomEmailFormField(
                  enabled: enabled,
                  controller: emailController,
                ),
                const SizedBox(height: 32),
                CustomTextFromField(
                  enabled: enabled,
                  isRequired: true,
                  labelText: 'Phone',
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                ),
                const SizedBox(height: 32),
                CustomDropDownMenu(
                  enabled: enabled,
                  controller: roleController,
                  values: const ['User', 'Admin'],
                  label: 'Select user type',
                ),
              ],
            )),
      ],
    );
  }
}
