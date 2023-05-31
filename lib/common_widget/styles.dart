import 'package:flutter/material.dart';
final linearGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFffffff).withOpacity(0.1),
      Color(0xFFFFFFFF).withOpacity(0.05),
    ],
    stops: [
      0.1,
      1,
    ]);
final linearGradient2 = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFFffffff).withOpacity(0.5),
    Color((0xFFFFFFFF)).withOpacity(0.5),
  ],
);
