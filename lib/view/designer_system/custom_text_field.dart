
import 'package:flutter/material.dart';

class CustomTextFieldDecorator{

  getInputDecorator(String label){
    return  InputDecoration(
      fillColor: Colors.white,
      filled: true,
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      ),
      hintText: label,
    );
  }
}