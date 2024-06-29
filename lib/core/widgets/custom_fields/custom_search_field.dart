import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
    this.onChanged,
  });
  final Function(String text)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged
      ,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      decoration: const InputDecoration(
        labelText: 'Search',
      ),
    );
  }
}
