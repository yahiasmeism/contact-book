import '../constants/colors.dart';
import '../constants/styles.dart';
import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton(
      {super.key, this.color, required this.child, required this.onPressed});

  final Color? color;
  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: COLORS.PRIMARY,
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: STYLES.TEXT_STYLE_20,
      ),
      onPressed: onPressed,
      child: Center(child: child),
    );
  }
}
