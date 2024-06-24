import '../constants/styles.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

ThemeData themeApp() {
  return ThemeData(
    scaffoldBackgroundColor: const Color(0xffF7F7F7),
    colorScheme: const ColorScheme.light().copyWith(primary: COLORS.PRIMARY),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            textStyle: TextStyle(fontSize: STYLES.TEXT_STYLE_18.fontSize),
            foregroundColor: Colors.black)),
    useMaterial3: false,
  );
}
