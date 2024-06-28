import 'package:flutter/material.dart';

import '../constants/styles.dart';

class CustomTextFromField extends StatelessWidget {
  const CustomTextFromField({
    super.key,
    this.labelText,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.isRequired = false,
    this.enabled = true,
    this.maxLines,
    this.floatingLabelBehavior,
  });
  final FloatingLabelBehavior? floatingLabelBehavior;
  final String? hintText;
  final int? maxLines;
  final bool enabled;
  final String? labelText;
  final TextEditingController? controller;
  final bool isRequired;
  final TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
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
        floatingLabelBehavior: floatingLabelBehavior,
        alignLabelWithHint: (maxLines ?? 0) > 1 ? true : false,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        contentPadding: const EdgeInsets.all(12),
        disabledBorder: const UnderlineInputBorder(),
        filled: enabled,
        hintText: hintText,
        labelText: labelText,
      ),
    );
  }
}
