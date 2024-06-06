import 'package:contact_book/core/constants/styles.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

ThemeData themeApp() {
  return ThemeData(
    colorScheme: const ColorScheme.light().copyWith(primary: COLORS.PRIMARY),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            textStyle: TextStyle(fontSize: STYLES.TEXT_STYLE_18.fontSize),
            foregroundColor: Colors.black)),
    useMaterial3: false,
  );
}
