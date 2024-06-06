import 'package:contact_book/core/constants/styles.dart';
import 'package:flutter/material.dart';

class CountryDropDownMenu extends StatelessWidget {
  const CountryDropDownMenu(
      {super.key, required this.countryController, this.enabled = true});
  final bool enabled;
  final TextEditingController countryController;

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
        label: const Text('Country'),
        controller: countryController,
        dropdownMenuEntries: const [
          DropdownMenuEntry(value: 'United States', label: 'United States'),
          DropdownMenuEntry(value: 'United Kingdom', label: 'United Kingdom'),
        ]);
  }
}
