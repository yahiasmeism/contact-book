import 'package:flutter/material.dart';

import '../constants/styles.dart';

class CustomTextFromField extends StatelessWidget {
  const CustomTextFromField({
    super.key,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.isRequired = false,
    this.enabled = true,
  });
  final bool enabled;
  final String labelText;
  final TextEditingController? controller;
  final bool isRequired;
  final TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      enabled: enabled,
      style: STYLES.TEXT_STYLE_18.copyWith(color: Colors.black),
      controller: controller,
      keyboardType: keyboardType,
      validator: (value) {
        if (!isRequired) return null;
        if (value == '' || value == null) {
          return '$labelText is required';
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
