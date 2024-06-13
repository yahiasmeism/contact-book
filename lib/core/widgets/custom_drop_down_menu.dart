import 'package:contact_book/core/constants/styles.dart';
import 'package:flutter/material.dart';

class CustomDropDownMenu extends StatelessWidget {
  const CustomDropDownMenu({
    super.key,
    this.controller,
    this.enabled = true,
    required this.values,
    required this.label,
  });
  final bool enabled;
  final TextEditingController? controller;
  final String label;
  final List<String> values;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      enabled: enabled,
      textStyle: STYLES.TEXT_STYLE_20.copyWith(color: Colors.black),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(12),
        disabledBorder: const UnderlineInputBorder(),
        fillColor: Colors.grey[200]!,
        filled: enabled,
        border: const UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.black,
        )),
      ),
      expandedInsets: EdgeInsets.zero,
      initialSelection: values.first,
      label: Text(label),
      controller: controller,
      dropdownMenuEntries: values
          .map((value) => DropdownMenuEntry(value: value, label: value))
          .toList(),
    );
  }
}
