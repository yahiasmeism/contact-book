// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../constants/styles.dart';

class CustomEmailFormField extends StatelessWidget {
  const CustomEmailFormField({
    super.key,
    this.controller,
    this.labelText = 'Email',
  });
  final TextEditingController? controller;
  final String? labelText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
        filled: true,
        labelText: labelText,
        labelStyle: STYLES.TEXT_STYLE_20,
      ),
    );
  }
}
