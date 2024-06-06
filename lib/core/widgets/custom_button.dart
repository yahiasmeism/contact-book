import '../constants/styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.color,
      required this.child,
      required this.onPressed,
      this.isLoading = false});

  final Color? color;
  final bool isLoading;
  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            // minimumSize: Size.fromWidth(MediaQuery.of(context).size.width),
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: STYLES.TEXT_STYLE_20),
        onPressed: onPressed,
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : child,
        ));
  }
}
