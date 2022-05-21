import 'package:flutter/material.dart';

Widget directoriesWidget({
  required title,
  required cardColor,
  required icon,
  required size,
  required context,
}) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    color: cardColor,
    child: SizedBox(
      height: size.height * 0.08,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14.0,
                letterSpacing: 1.0,
              ),
            ),
            icon,
          ],
        ),
      ),
    ),
  );
}
