import 'package:contact_book/core/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    this.indent,
    this.endIndent,
    this.color = COLORS.BORDER,
  });
  final double? indent;
  final double? endIndent;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: indent,
      endIndent: endIndent,
      color: color,
      thickness: 1,
      height: 0,
    );
  }
}
