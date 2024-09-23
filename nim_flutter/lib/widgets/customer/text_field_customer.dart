
import 'package:flutter/material.dart';

InputDecoration customTextField(String label) {
    return InputDecoration(
        
        label: Text(label),
        filled: true,
        fillColor: Colors.pink[300],
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        labelStyle:const TextStyle(
          color: Colors.black,
          fontSize: 13.0,
        ),

        contentPadding: const EdgeInsets.all(20.0),
        errorText: label.isEmpty ? 'Insira os campos' : null,
      );
}