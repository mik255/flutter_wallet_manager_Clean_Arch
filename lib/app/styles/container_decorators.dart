

import 'package:flutter/material.dart';

class ContainerDecorators{
   BoxDecoration getBoxDecoration({required Color color}){
    return BoxDecoration(
      border: Border.all(color: color,width: 3),
      color: color,
      shape: BoxShape.circle,
    );
  }
     BoxDecoration getOutLineBorderDecorator({required Color color}){
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.transparent,
      border: Border.all(
        color: color,
        width: 1,
      ),
    );
  }
   ShapeDecoration solidGrayCard(){
     return  ShapeDecoration(
         color: const Color(0xFFE6EAF0),
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
       );
   }

}