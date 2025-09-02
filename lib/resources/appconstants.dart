import 'package:flutter/material.dart';

class AppConstants {
  static const LinearGradient customGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromARGB(255, 126, 57, 23),
      Color.fromARGB(255, 202, 126, 88),
    ],
  );
  static const LinearGradient customGradientForBar = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(255, 126, 57, 23),
      Color.fromARGB(255, 202, 126, 88),
    ],
  );
}
