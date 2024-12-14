import 'package:flutter/material.dart';

class AppTheme {
  final Color _colorOutline = const Color.fromARGB(255, 2, 74, 129);

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: Colors.blue[200],
          selectionHandleColor: Colors.blue[200],
        ),
        iconTheme: IconThemeData(
          color: _colorOutline,
          size: 25,
        ),
        inputDecorationTheme: InputDecorationTheme(
          suffixIconColor: _colorOutline,
          hoverColor: _colorOutline,
          focusColor: _colorOutline,
          iconColor: _colorOutline,
          fillColor: Colors.transparent,
          border: const OutlineInputBorder(),
          labelStyle: TextStyle(
            color: _colorOutline,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            decorationColor: Colors.blue,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: _colorOutline,
              width: 2,
            ),
          ),
        ),
      );
}
