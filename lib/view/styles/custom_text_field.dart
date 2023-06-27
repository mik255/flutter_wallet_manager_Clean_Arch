
import 'package:flutter/material.dart';

class CustomTextFieldDecorator{

  getInputDecorator(String label,{Color color = Colors.white}){
    return  InputDecoration(
      fillColor: color,
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