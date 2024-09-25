import 'package:flutter/material.dart';
import 'package:nim_flutter/widgets/customer/format_container.dart';
import 'package:nim_flutter/widgets/customer/grid_delegade.dart';
import 'package:nim_flutter/widgets/customer/text_field_customer.dart';
import 'package:nim_flutter/widgets/customer/text_style_jogo.dart';

class NimGame extends StatelessWidget {
  final int qntJogo;
  final String currentPlayer;
  final int qntRetirar;
  final jogar;

  const NimGame(
      {super.key,
      required this.jogar,
      required this.qntJogo,
      required this.currentPlayer,
      required this.qntRetirar});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // jogador atual
            Container(
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Text(
                    "Jogador atual: ",
                    style: styleText(),
                  ),
                  Text(
                    currentPlayer,
                    style: styleText(),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 400,
              width: 400,
              child: GridView.builder(
                gridDelegate: gridDelegate(),
                itemBuilder: (context, index) => formaContainer(),
                itemCount: qntJogo,
                shrinkWrap: true,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(onPressed: () => jogar(), child: Text("Jogar")),
            Text(
              "$currentPlayer retirou $qntRetirar do jogo",
              style: styleText(),
            ),
          ],
        ),
      ),
    );
  }
}
