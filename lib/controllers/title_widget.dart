import 'package:flutter/material.dart';

Widget settingsLabelWidget({
  required title,
  required width,
  required height,
  required fontSize,
  required fontColor,
  required fontWeight,
  required letterSpacing,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: height, vertical: width),
    child: Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        color: fontColor,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
      ),
    ),
  );
}
