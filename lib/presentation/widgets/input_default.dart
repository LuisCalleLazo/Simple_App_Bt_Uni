import 'package:flutter/material.dart';

class InputDefault extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final TextInputType type;
  final Color color;
  final InputDecoration? decoration;
  final bool enabled;
  final EdgeInsetsGeometry? contentPadding;

  const InputDefault({
    super.key,
    required this.label,
    required this.controller,
    required this.icon,
    required this.type,
    required this.color,
    this.decoration,
    this.enabled = true,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      enabled: enabled,
      style: TextStyle(color: color),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: color),
        contentPadding: contentPadding ?? const EdgeInsets.only(bottom: 10),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
    );
  }
}
