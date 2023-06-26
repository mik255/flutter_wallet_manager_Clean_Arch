import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFieldDecorator{

  getInputDecorator(String label){
    return  InputDecoration(
      border: const OutlineInputBorder(),
      labelText: label,
    );
  }
}