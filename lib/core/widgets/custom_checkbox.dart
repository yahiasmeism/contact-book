import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({
    required this.onChange,
    super.key,
  });
  final Function(bool value)? onChange;
  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: COLORS.PRIMARY,
      value: isChecked,
      onChanged: (value) {
        setState(() {
          isChecked = value!;
          widget.onChange!(isChecked);
        });
      },
    );
  }
}
