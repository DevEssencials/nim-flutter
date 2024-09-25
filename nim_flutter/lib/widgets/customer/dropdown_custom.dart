import 'package:flutter/material.dart';

InputDecoration decorationDropdown(String value) {
  return InputDecoration(
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
    errorText: value == 'Escolher Modo' ? 'Escolha algum modo' : null,
  );
}
