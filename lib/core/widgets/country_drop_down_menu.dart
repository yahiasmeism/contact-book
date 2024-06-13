import 'package:flutter/material.dart';

import 'package:contact_book/core/widgets/custom_drop_down_menu.dart';

class CountryDropDownMenu extends StatelessWidget {
  const CountryDropDownMenu({
    super.key,
    required this.countryController,
    this.enabled = true,
  });
  final bool enabled;
  final TextEditingController countryController;
  @override
  Widget build(BuildContext context) => CustomDropDownMenu(
        enabled: enabled,
        label: 'Country',
        values: const ['United Kingdom', 'United Status'],
        controller: countryController,
      );
}
