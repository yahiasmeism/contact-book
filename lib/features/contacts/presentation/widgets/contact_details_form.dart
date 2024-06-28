import '../../../../core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_email_form_field.dart';

class ContactDetailsForm extends StatelessWidget {
  const ContactDetailsForm({
    super.key,
    required this.formKey,
    this.enabled = true,
    required this.fNameController,
    required this.lNameController,
    required this.emailController,
    required this.phoneController,
    required this.email2Controller,
    required this.mobileController,
    required this.addressController,
    required this.address2Controller,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController fNameController;
  final TextEditingController lNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController email2Controller;
  final TextEditingController mobileController;
  final TextEditingController addressController;
  final TextEditingController address2Controller;

  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 16),
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
                  labelText: 'Email',
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
                CustomEmailFormField(
                  isRequired: false,
                  labelText: 'Email 2',
                  enabled: enabled,
                  controller: email2Controller,
                ),
                const SizedBox(height: 32),
                CustomTextFromField(
                  enabled: enabled,
                  labelText: 'Mobile',
                  keyboardType: TextInputType.phone,
                  controller: mobileController,
                ),
                const SizedBox(height: 32),
                CustomTextFromField(
                  maxLines: 4,
                  enabled: enabled,
                  isRequired: true,
                  labelText: 'Address',
                  controller: addressController,
                ),
                const SizedBox(height: 32),
                CustomTextFromField(
                  maxLines: 4,
                  enabled: enabled,
                  labelText: 'Address 2',
                  controller: address2Controller,
                ),
              ],
            )),
      ],
    );
  }
}
