import 'package:flutter/material.dart';
import 'package:nim_flutter/widgets/customer/customer_game_page.dart';
import 'package:nim_flutter/widgets/customer/format_container.dart';
import 'package:nim_flutter/widgets/customer/grid_delegade.dart';

class NimGame extends StatefulWidget {
  final int qntJogo;
  final String currentPlayer;
  final int qntRetirar;
  final Function(int) jogar;
  final bool jogada;
  final bool isComp;
  final Function? jogarComp;

  const NimGame({
    super.key,
    required this.jogarComp,
    required this.isComp,
    required this.jogada,
    required this.jogar,
    required this.qntJogo,
    required this.currentPlayer,
    required this.qntRetirar,
  });

  @override
  State<NimGame> createState() => _NimGameState();
}

class _NimGameState extends State<NimGame> {
  int palitosParaRetirar = 1;

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
                  // ignore: unnecessary_null_comparison
                  value: (palitosParaRetirar != null &&
                          // ignore: unnecessary_null_comparison
                          palitosParaRetirar <=
                              (widget.qntRetirar != null &&
                                      widget.qntRetirar! <= widget.qntJogo
                                  ? widget.qntRetirar!
                                  : widget.qntJogo))
                      ? palitosParaRetirar
                      : null, // Verifica se o valor é válido, senão deixa null
                  items: List.generate(
                    (widget.qntRetirar != null &&
                            widget.qntRetirar! <= widget.qntJogo)
                        ? widget.qntRetirar!
                        : widget.qntJogo,
                    (index) {
                      print('Gerando item: ${index + 1}');
                      return index + 1;
                    },
                  ).map((value) {
                    print('Mapeando valor: $value');
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(
                        value.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      if (value != null && widget.jogada) {
                        palitosParaRetirar = value;
                        print('Novo valor selecionado: $palitosParaRetirar');
                      } else {
                        print('Jogada inválida');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Não foi possível fazer a jogada!",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    });
                  },
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  dropdownColor: Colors.white,
                )
              ],
            ),

            const SizedBox(height: 50),

            // Botão Jogar estilizado
            ElevatedButton(
              style: elevatedButtonStyle(), // Usando o estilo do botão
              onPressed: () {
                setState(() {
                  if (widget.jogada) {
                    if (!widget.isComp) {
                      widget.jogar(palitosParaRetirar);
                      ScaffoldMessenger.of(context).showSnackBar(
                        snackBarStyle(
                            '${widget.currentPlayer} retirou $palitosParaRetirar palito(s).'), // Estilo do Snackbar
                      );
                    } else {
                      widget.jogarComp!();
                      ScaffoldMessenger.of(context).showSnackBar(
                        snackBarStyle(
                            'Aguarde a jogada do computador'), // Estilo do Snackbar
                      );
                    }
                  }
                });
              },
              child: const Text(
                "Jogar",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
