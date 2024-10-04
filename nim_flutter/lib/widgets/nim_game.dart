import 'package:flutter/material.dart';
import 'package:nim_flutter/widgets/customer/customer_game_page.dart';
import 'package:nim_flutter/widgets/customer/format_container.dart';
import 'package:nim_flutter/widgets/customer/grid_delegade.dart';

class NimGame extends StatefulWidget {
  final int qntJogo;
  final String currentPlayer;
  final int qntRetirar;
  final Function(int) jogar;
  //final bool jogada;

  const NimGame({
    super.key,
    //required this.jogada,
    required this.jogar,
    required this.qntJogo,
    required this.currentPlayer,
    required this.qntRetirar,
  });

  @override
  State<NimGame> createState() => _NimGameState();
}

class _NimGameState extends State<NimGame> {
  int? palitosParaRetirar; // Make palitosParaRetirar nullable

  @override
  void initState() {
    super.initState();
    palitosParaRetirar = null; // Set initial value to null
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("NIM GAME"),
        backgroundColor: primaryColor, // Cor principal do AppBar
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Jogador atual
            Container(
              decoration:
                  containerDecoration(), // Usando o estilo customizado para o container
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Jogador atual: ",
                    style:
                        primaryTextStyle(), // Usando o estilo customizado para o texto
                  ),
                  Text(
                    widget.currentPlayer,
                    style: primaryTextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold), // Texto em destaque
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            // Quantidade de palitos restante
            SizedBox(
              height: 300,
              width: 400,
              child: GridView.builder(
                gridDelegate: gridDelegate(),
                itemBuilder: (context, index) => formaContainer(),
                itemCount: widget.qntJogo,
                shrinkWrap: true,
              ),
            ),
            const SizedBox(height: 20),
            // Dropdown para escolher quantos palitos retirar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Escolha quantos palitos retirar:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                DropdownButton<int>(
                  value: palitosParaRetirar, // Use the nullable value
                  items: List.generate(
                    _getValidRetirarLimit(widget.qntRetirar, widget.qntJogo),
                    (index) => index + 1,
                  ).map((value) => DropdownMenuItem<int>(
                    value: value,
                    child: Text(
                      value.toString(),
                      style: const TextStyle(fontSize: 18),
                    ),
                  )).toList(),
                  onChanged: (value) {
                    setState(() {
                      palitosParaRetirar = value; // Update the value
                      print('Novo valor selecionado: $palitosParaRetirar');
                    });
                  },
                  style: const TextStyle(color: Colors.black),
                  dropdownColor: Colors.white,
                  hint: const Text("Selecione"), // Display a hint when value is null
                  disabledHint: palitosParaRetirar == null
                      ? const Text("Insira algum valor") // Show message when null
                      : null,
                ),
              ],
            ),
            const SizedBox(height: 50),
            // Botão Jogar estilizado (disabled if value is null)
            elevatedButtonWithAction(
              text: "Jogar",
              onPressed: palitosParaRetirar != null
                  ? () => _handleJogarButton() // Enable button if value is not null
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  // Utility functions for cleaner code
  int _getValidRetirarLimit(int? qntRetirar, int qntJogo) {
    return qntRetirar != null && qntRetirar <= qntJogo ? qntRetirar : qntJogo;
  }

  // Function for handling the jogar button press
 void _handleJogarButton() {
    widget.jogar(palitosParaRetirar!); // Passe o valor de palitosParaRetirar (certifique-se de que não seja nulo!)
    
    ScaffoldMessenger.of(context).showSnackBar(
      snackBarStyle(
        '${widget.currentPlayer} retirou $palitosParaRetirar palito(s).'),
    );
    setState(() {
      palitosParaRetirar = null; 
    });
}
ElevatedButton elevatedButtonWithAction({
  required String text,
  required VoidCallback? onPressed,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: elevatedButtonStyle(),
    child: Text(
      text, 
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}
Widget containerWithText({
  required String text,
  TextStyle? textStyle,
}) {
  return Container(
    padding: EdgeInsets.all(16),
    child: Text(
      text,
      style: textStyle,
    ),
  );
}
}

