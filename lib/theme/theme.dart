import 'package:flutter/material.dart';

class AppTheme {
  static final theme = ThemeData(
    inputDecorationTheme: inputDecorationTheme,
  );

  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      fillColor: Colors.white,
      filled: true,
      border: textFieldBorder,
      errorBorder: textFieldBorder.copyWith(
          borderSide: const BorderSide(width: 0.5, color: Colors.red)),
      focusedBorder: textFieldBorder,
      enabledBorder: textFieldBorder,
      errorStyle: const TextStyle(color: Colors.red));

  static InputBorder textFieldBorder = const OutlineInputBorder(
    borderSide: BorderSide(
        width: 0.5, style: BorderStyle.solid, color: Color(0xFFB8B8D2)),
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );
}
