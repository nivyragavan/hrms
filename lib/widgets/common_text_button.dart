import 'package:flutter/material.dart';

class CommonTextButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback onPressed;
  const CommonTextButton(
      {Key? key,
      required this.text,
      required this.textColor,
      required this.fontSize,
      required this.fontWeight,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              fontSize: fontSize, fontWeight: fontWeight, color: textColor),
        ));
  }
}
