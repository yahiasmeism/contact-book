import 'package:flutter/material.dart';

import '../constants/styles.dart';

class CustomPasswordFormField extends StatefulWidget {
  const CustomPasswordFormField({
    super.key,
    this.labelText = 'Password',
    this.controller,
  });
  final TextEditingController? controller;
  final String labelText;
  @override
  State<CustomPasswordFormField> createState() =>
      _CustomPasswordFormFieldState();
}

class _CustomPasswordFormFieldState extends State<CustomPasswordFormField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password is required';
        }
        return null;
      },
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      obscureText: _obscureText,
      decoration: InputDecoration(
        filled: true,
        labelText: widget.labelText,
        labelStyle: STYLES.TEXT_STYLE_20,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
          ),
        ),
      ),
    );
  }
}
