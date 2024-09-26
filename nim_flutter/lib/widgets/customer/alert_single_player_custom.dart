import 'package:flutter/material.dart';

TextStyle customTitleTextStyle() {
  return const TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}

ButtonStyle customButtonStyle() {
  return ElevatedButton.styleFrom(
    minimumSize: const Size(900, 50), // Aumenta a largura e altura
    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
  );
}

TextStyle customButtonTextStyle() {
  return const TextStyle(
    color: Color.fromARGB(255, 255, 35, 109),
    fontWeight: FontWeight.w900,
  );
}

InputDecoration customInputDecorations() {
  return const InputDecoration(
    hintText: 'Nome do Jogador',
    hintStyle: TextStyle(color: Colors.white54),
    border: OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
  );
}
