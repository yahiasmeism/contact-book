import 'package:flutter/material.dart';

import '../constants/styles.dart';

class CustomEmailFormField extends StatelessWidget {
  const CustomEmailFormField({
    super.key,
    this.controller,
    this.labelText = 'Email',
    this.enabled = true,
    this.isRequired = true,
    this.floatingLabelBehavior,
    this.hintText,
  });
  final TextEditingController? controller;
  final String? labelText;
  final bool enabled;
  final bool isRequired;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: STYLES.TEXT_STYLE_18.copyWith(color: Colors.black),
      enabled: enabled,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (isRequired) {
          if (value == null || value.isEmpty) {
            return 'Email is required';
          }
        }
        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
        if (value!.isNotEmpty && !emailRegex.hasMatch(value)) {
          return 'Email is invalid';
        }
        return null;
      },
      decoration: InputDecoration(
        floatingLabelBehavior: floatingLabelBehavior,
        hintText: hintText,
        contentPadding: const EdgeInsets.all(12),
        disabledBorder: const UnderlineInputBorder(),
        filled: enabled,
        labelText: labelText,
      ),
    );
  }
}
