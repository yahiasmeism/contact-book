// ignore_for_file: must_be_immutable

import 'package:contact_book/core/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });
  bool value;
  final Function(bool value) onChanged;
  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.9,
      child: AnimatedContainer(
        height: 40,
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Colors.black.withOpacity(.23),
          ),
          borderRadius: BorderRadius.circular(100),
          color: widget.value ? COLORS.PRIMARY : const Color(0xffE6E0E9),
        ),
        child: Transform.scale(
          scale: 1.2,
          child: Switch(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            trackColor: const WidgetStatePropertyAll(Colors.transparent),
            thumbColor: WidgetStatePropertyAll(
              widget.value ? Colors.white : const Color(0xff79747E),
            ),
            value: widget.value,
            onChanged: (value) {
              setState(() {
                widget.value = value;
                widget.onChanged(value);
              });
            },
          ),
        ),
      ),
    );
  }
}
