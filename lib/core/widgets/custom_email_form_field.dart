
import 'package:flutter/material.dart';

import '../constants/styles.dart';

class CustomEmailFormField extends StatelessWidget {
  const CustomEmailFormField({
    super.key,
    this.controller,
    this.labelText = 'Email',
    this.enabled = true,
  });
  final TextEditingController? controller;
  final String? labelText;
  final bool enabled;
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
        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

        if (value == null || value.isEmpty) {
          return 'Email is required';
        } else if (!emailRegex.hasMatch(value)) {
          return 'Email is invalid';
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(12),
        disabledBorder: const UnderlineInputBorder(),
        filled: enabled,
        labelText: labelText,
      ),
    );
  }
}
