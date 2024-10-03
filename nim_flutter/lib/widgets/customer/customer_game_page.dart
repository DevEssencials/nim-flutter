import 'package:flutter/material.dart';

// Cores principais do tema
const Color primaryColor = Color(0xFFFF4081);

// Estilo para o texto principal
TextStyle primaryTextStyle({double fontSize = 20, FontWeight fontWeight = FontWeight.w600, Color color = Colors.white}) {
  return TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );
}

// Estilo do botão
ButtonStyle elevatedButtonStyle() {
  return ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    backgroundColor: primaryColor,
  );
}

// Estilo de Snackbar
SnackBar snackBarStyle(String message) {
  return SnackBar(
    content: Text(message),
    backgroundColor: primaryColor,
    duration: const Duration(seconds: 1),
  );
}

// Decoração para o container
BoxDecoration containerDecoration() {
  return BoxDecoration(
    color: primaryColor,
    borderRadius: BorderRadius.circular(12),
  );
}

