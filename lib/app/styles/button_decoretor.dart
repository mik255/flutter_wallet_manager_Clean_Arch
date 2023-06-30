import 'package:flutter/material.dart';

class CustomButtonStyle {
  getStyle() {
    return ElevatedButton.styleFrom(
      elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ));
  }
}
