// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomCheckBox extends StatefulWidget {
  CustomCheckBox({
    required this.onChange,
    super.key,
    this.initalValue = false,
  });
  final Function(bool value)? onChange;
  bool initalValue;
  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      
      visualDensity: VisualDensity.compact,
      activeColor: COLORS.PRIMARY,
      value: widget.initalValue,
      onChanged: (value) {
        setState(() {
          widget.initalValue = value!;
          widget.onChange!(widget.initalValue);
        });
      },
    );
  }
}
