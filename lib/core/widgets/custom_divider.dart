import '../constants/colors.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    this.indent,
    this.endIndent,
    this.color = COLORS.BORDER,
    this.height = 0,
  });
  final double? indent;
  final double? endIndent;
  final Color? color;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: indent,
      endIndent: endIndent,
      color: color,
      thickness: 1,
      height: height,
    );
  }
}
