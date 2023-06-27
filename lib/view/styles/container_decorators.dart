

import 'package:flutter/material.dart';

class ContainerDecorators{
   BoxDecoration getBoxDecoration({required Color color}){
    return BoxDecoration(
      color: color,
      shape: BoxShape.circle,
    );
  }
}