import 'package:flutter/material.dart';

class StyledText extends Text {

  // Build styled text
  StyledText(String data, {textAlign: TextAlign.justify, color: Colors.deepOrange, double factor}) :
    super(
      data,
      textAlign: textAlign,
      textScaleFactor: factor,
      style: TextStyle(color: color),
    );
}