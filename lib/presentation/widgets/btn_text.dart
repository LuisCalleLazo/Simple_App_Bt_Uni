import 'package:flutter/material.dart';

class BtnTextDefault extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final double? width;
  final double? heigth;
  final double? fontSize;
  final Color color;
  const BtnTextDefault({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = 300.0,
    this.heigth = 60,
    this.fontSize = 18,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(color),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Container(
          padding: const EdgeInsetsDirectional.symmetric(vertical: 10),
          width: width,
          height: heigth,
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontFamily: "",
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
