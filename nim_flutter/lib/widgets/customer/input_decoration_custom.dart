import 'package:flutter/material.dart';

InputDecoration customInputDecoration() {
  return const InputDecoration(
    enabledBorder: UnderlineInputBorder(
      // Define a borda quando não está em foco
      borderSide: BorderSide(
        color: const Color.fromARGB(255, 225, 225, 225), // Cor da linha
        width: 2.0, // Espessura da linha
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      // Define a borda quando está em foco
      borderSide: BorderSide(
        color: Colors.white, // Cor da linha em foco
        width: 3.0, // Espessura da linha em foco
      ),
    ),
  );
}
