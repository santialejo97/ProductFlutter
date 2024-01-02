

import 'package:flutter/material.dart';

class InputDecorations{

  static InputDecoration inputDecorations({
   required String hintText, 
   required String labelText, 
   required String helperText,
   IconData? prefixIcon,
  }){
    return InputDecoration(
            suffixIcon:const Icon(Icons.people_outline, color: Colors.purple,),
            prefixIcon:prefixIcon != null 
            ? Icon(prefixIcon, color: Colors.purple) 
            : null,
            helperText: helperText,
            hintText: hintText,
            labelText: labelText,
            labelStyle:const TextStyle(color: Colors.grey),
            enabledBorder:const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.purple)
            ),
            focusedBorder:const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.purple, width: 3)
            )
          );
  }
}