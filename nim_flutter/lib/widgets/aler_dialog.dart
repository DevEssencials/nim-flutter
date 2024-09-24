import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final controller;
  final controller2;
  const DialogBox({super.key, required this.controller, required this.controller2});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.pink[100],
      content: Container(
        height: 190,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Insira o nome do jogadores"),
            TextFormField(
              controller: controller,
            ),
            TextFormField(
              controller: controller2,
            ),
          ],
        ),
      ),
    );
  }
}