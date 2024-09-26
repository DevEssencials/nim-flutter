import 'package:flutter/material.dart';

InputDecoration customTextField(String label) {
  return InputDecoration(
    hintText: label,
    hintMaxLines: 3,
    hintStyle: const TextStyle( color:  Colors.white),
    filled: true,
    fillColor: const Color.fromARGB(255, 255, 35, 109),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide.none,
    ),
    /* 
    labelStyle: const TextStyle(
      color: Colors.white,
      fontSize: 13.0,
    ), */
    contentPadding: const EdgeInsets.all(20.0),
    errorText: label.isEmpty ? 'Insira os campos' : null,
  );
}
